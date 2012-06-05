require 'rubygems'
require 'nokogiri'

Dir.foreach('.') do |state|

  next if state == "." or state == ".."
  if Dir.exists?(state)
    Dir.foreach(File.join(state)) do |zip|
      next if zip == "." or zip == ".."
      if Dir.exists?(File.join state, zip)
        Dir.foreach(File.join(state,zip)) do |filename|
          next if filename == "." or filename == ".."
          p "Processing State = #{state} - Zip = #{zip}..."
          p "Parsing Filename = #{File.join(state,zip,filename)}"
          file = Nokogiri::HTML::Document.parse(File.open(File.join(state,zip,filename)))
          results = file.css('#ctl00_cphMainContent_grResults > tr')
          results.shift
          results.shift
          results.pop
          results.each do |r|
            p "Adding ..."
            #IAR NAME
            iar_name = r.css('td:nth-child(1)').children[1].text.gsub("\r\n",'').squeeze rescue nil
            #IAR CRD
            iar_crd = r.css('td:nth-child(1)').children[2].text.gsub("(",'').gsub(")",'').to_i rescue nil

            p "IAR #{iar_name} (#{iar_crd})"
            firm_data = r.css('td:nth-child(3) > table > tr')

            firms = {}
            latest_firm_name = ""
            latest_firm_crd = ""
            firm_data.each do |data|
              firm_name_and_crd = data.css('td[colspan="3"]')
              firm_location = data.css('td.SearchResultsAddress')

              if firm_location.empty? and !firm_name_and_crd.empty?
                iaf_name = firm_name_and_crd.children[0].text.gsub("\r\n",'').squeeze rescue nil
                iaf_crd = firm_name_and_crd.children[1].text.gsub("\r\n",'').gsub("(",'').gsub(")",'').to_i rescue nil
                latest_firm_name = iaf_name
                latest_firm_crd = iaf_crd
                firms[iaf_crd] = {:name => iaf_name, :locations => []}
                p "(1) FOUND FIRM NAME #{iaf_name} CRD #{iaf_crd} "
              elsif !firm_location.empty? and firm_name_and_crd.empty?
                locations = firm_location.css('li')
                locations.each do |loc|
                  firm_loc_street = loc.children[0].text.gsub("\r\n",'') rescue nil
                  firm_loc_city_zip = loc.children[2].text.gsub("\r\n",'') rescue nil
                  firms[latest_firm_crd][:locations] << {:street => firm_loc_street, :city_zip => firm_loc_city_zip}
                  p "(2)FIRM #{latest_firm_name} ADD LOC #{firm_loc_street} - #{firm_loc_city_zip} "
                end
              elsif !firm_location.empty? and !firm_name_and_crd.empty?
                p 'Nested Firm!!!'
                locations = firm_location.css('li')
                locations.each do |loc|
                  firm_loc_street = loc.children[0].text.gsub("\r\n",'') rescue nil
                  firm_loc_city_zip = loc.children[2].text.gsub("\r\n",'') rescue nil
                  firms[latest_firm_crd][:locations] << {:street => firm_loc_street, :city_zip => firm_loc_city_zip}
                  p "(3)FIRM #{latest_firm_name} ADD LOC #{firm_loc_street} - #{firm_loc_city_zip} "
                  iaf_name = firm_name_and_crd.children[0].text.gsub("\r\n",'').squeeze rescue nil
                  iaf_crd = firm_name_and_crd.children[1].text.gsub("\r\n",'').gsub("(",'').gsub(")",'').to_i rescue nil
                  latest_firm_name = iaf_name
                  latest_firm_crd = iaf_crd
                  firms[iaf_crd] = {:name => iaf_name, :locations => []} if firms[iaf_crd].nil?
                  p "(3)FOUND FIRM NAME #{iaf_name} CRD #{iaf_crd} "
                end
              end

            end
            p firms.inspect

            p "... Done"
          end
        end
      end
    end
  end
end