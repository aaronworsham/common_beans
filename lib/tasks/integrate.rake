require 'nokogiri'
require 'csv'
namespace :cb do
  namespace :integrate do

    namespace :brightscope do
      desc 'grab from BS'
      task :firms => :environment do
        #firms
        first_page = Nokogiri::HTML(open('http://www.brightscope.com/financial-planning/find/firm/1/?search_expanded=0&address_city=&address_state=MI&firm_service=&firm_name='))
        pages = first_page.css('#search_result_counts').text.gsub(',','').slice(/\d+/).to_i/15
        pages.times do |p|
          p += 1
          p "Page #{p}..."
          html = (p == 1) ? first_page :  Nokogiri::HTML(open('http://www.brightscope.com/financial-planning/find/firm/1/?search_expanded=0&address_city=&address_state=MI&firm_service=&firm_name='))
          firms = html.css('.search_result_item')
          firms.each do |a|
            firm_brightscope_id = a.css('.firm_result_details a').attribute('href').value.split('/').last.to_i
            firm_name = a.css('.firm_result_details a').text
            firm_address = a.css('.firm_result_details div').text
            p "Adding #{firm_brightscope_id} - #{firm_name} - #{firm_address} ..."
            details = Nokogiri::HTML(open("http://www.brightscope.com/financial-planning/firm/#{firm_brightscope_id}"))
            url = details.css('.sidebar_box_container .key_information tr:nth-child(5) a').attribute('href').value
            address = details.css('.principal_office .key_information address').text.squeeze.gsub(/[\n?|\t?]/, "")
            phone = details.css('.principal_office .key_information tr:nth-child(2) td').text.squeeze.gsub(/[\n?|\t?]/, "")
            p "url #{url} - address #{address} - Phone #{phone}"
          end
        end
      end
      desc 'grab from BS'
      task :advisers => :environment do
        #Advisors
        first_page = Nokogiri::HTML(open('http://www.brightscope.com/financial-planning/find/advisor/1/?address_city=&search_expanded=0&advisor_service=&advisor_name=&address_state=MI'))
        pages = first_page.css('#search_result_counts').text.gsub(',','').slice(/\d+/).to_i/15
        pages.times do |p|
          p += 1
          p "Page #{p}..."
          html = (p == 1) ? first_page :  Nokogiri::HTML(open("http://www.brightscope.com/financial-planning/find/advisor/#{p}/?address_city=&search_expanded=0&advisor_service=&advisor_name=&address_state=MI"))
          advisors = html.css('.search_result_item')
          advisors.each do |a|
            advisor_brightscope_id = a.css('.advisor_result_details a').attribute('href').value.split('/').last.to_i
            name = a.css('.advisor_result_details a').text
            firm = a.css('.advisor_result_details .result_firm_address')[0].text
            firm_address = a.css('.advisor_result_details .result_firm_address')[1].text
            p "Adding #{advisor_brightscope_id} - #{name} - #{firm} - #{firm_address}..."
            details = Nokogiri::HTML(open("http://www.brightscope.com/financial-planning/advisor/#{advisor_brightscope_id}"))
            firm_brightscope_id = details.css('.advisor_details_table tr:first td:first a').attribute('href').value.split('/')[-2].to_i
            advisor_address = details.css('.key_information address').text.squeeze.gsub(/[\n?|\t?]/, "")
            firm_table =  details.css('.firm_table tr')
            data = []
            firm_table.each do |ft|
              data << ft.children[0].text.squeeze.gsub(/[\n?|\t?]/, "")
              data << ft.children[1].text.squeeze.gsub(/[\n?|\t?]/, "")
              data << ft.children[2].text.squeeze.gsub(/[\n?|\t?]/, "")
            end
            social_media = []
            html.css('.information_display a').each do |sm|
              social_media << sm.attribute('href').value
            end
            p "Social Media #{social_media.inspect}"
            p "Firm ID #{firm_brightscope_id} - Adviser Address - #{advisor_address} "
            p "Data #{data.inspect}"

          end
        end
        p pages
      end
    end

    namespace :yahoo_finance do
      desc 'add data from yahoo finance'
      task :stock => :environment do
        stock = StockTicker.all
        CSV.open('db/data/stock_profiles.csv', 'wb') do |csv|
          csv << ["Stock Symbol","Business Summary","Sector","Industry","URL"]
          stock.each do |s|
            business_summary = "N/A"
            sector = "N/A"
            industry = "N/A"
            url = "N/A"
            p s.inspect
            stock_symbol = s.symbol
            p "gathering data for symbol #{stock_symbol}"
            retry_count = 0
            begin
              first_page = Nokogiri::HTML(open("http://finance.yahoo.com/q/pr?s=#{stock_symbol}"))
              if first_page.at_css("body div#rightcol table#yfncsumtab tr td p") != nil
                business_summary = first_page.at_css("body div#rightcol table#yfncsumtab tr td p").text
              end
              if first_page.at_css("body div#rightcol table#yfncsumtab tr td table.yfnc_datamodoutline1 tr:nth-child(2) td.yfnc_tabledata1 a") !=nil
                sector = first_page.at_css("body div#rightcol table#yfncsumtab tr td table.yfnc_datamodoutline1 tr:nth-child(2) td.yfnc_tabledata1 a").children.text
              end
              if first_page.at_css("body div#rightcol table#yfncsumtab tr td table.yfnc_datamodoutline1 tr:nth-child(3) td.yfnc_tabledata1 a") !=nil
                industry = first_page.at_css("body div#rightcol table#yfncsumtab tr td table.yfnc_datamodoutline1 tr:nth-child(3) td.yfnc_tabledata1 a").children.text
              end
              if first_page.css("body div#rightcol table#yfncsumtab tr td.yfnc_modtitlew1 table")[5] !=nil
                url = first_page.css("body div#rightcol table#yfncsumtab tr td.yfnc_modtitlew1 table")[5].css("tr td a")[0].first[1]
              end
            rescue
              puts "Something timed out, waiting a few seconds"
              sleep(3.seconds)
              retry_count +=1
              retry if retry_count < 5
            end
            csv << [stock_symbol, business_summary, sector, industry, url]
          end
        end
      end

      task :fund => :environment do
        fund = FundTicker.all
        CSV.open('db/data/fund_profiles.csv', 'wb') do |csv|
          csv << ["Symbol","Category","Family","Inception Date","Summary"]
          fund.each do |f|
            fund_symbol = f.symbol
            category = "N/A"
            family = "N/A"
            inception_date = "N/A"
            summary = "N/A"
            p f.inspect
            p "gathering data for fund symbol #{fund_symbol}"
            retry_count = 0
            begin
              first_page = Nokogiri::HTML(open("http://finance.yahoo.com/q/pr?s=#{fund_symbol}"))
              if first_page.css("body div#rightcol table#yfncsumtab td.yfnc_modtitlew1 table.yfnc_datamodoutline1 td.yfnc_datamoddata1")[0] != nil
                category = first_page.css("body div#rightcol table#yfncsumtab td.yfnc_modtitlew1 table.yfnc_datamodoutline1 td.yfnc_datamoddata1")[0].text
              end
              if first_page.css("body div#rightcol table#yfncsumtab td.yfnc_modtitlew1 table.yfnc_datamodoutline1 td.yfnc_datamoddata1")[1] !=nil
                family = first_page.css("body div#rightcol table#yfncsumtab td.yfnc_modtitlew1 table.yfnc_datamodoutline1 td.yfnc_datamoddata1")[1].text
              end
              if first_page.css("body div#rightcol table#yfncsumtab td.yfnc_modtitlew1 table.yfnc_datamodoutline1 td.yfnc_datamoddata1")[6] !=nil
                inception_date = first_page.css("body div#rightcol table#yfncsumtab td.yfnc_modtitlew1 table.yfnc_datamodoutline1 td.yfnc_datamoddata1")[6].text
              end
              if first_page.css("body div#rightcol table#yfncsumtab td.yfnc_modtitlew2 table")[2] !=nil
                summary = first_page.css("body div#rightcol table#yfncsumtab td.yfnc_modtitlew2 table")[2].text
              end
            rescue
              puts "Something timed out, waiting a few seconds"
              sleep(3.seconds)
              retry_count +=1
              retry if retry_count < 5
            end
            csv << [fund_symbol, category, family, inception_date, summary]
          end
        end
      end
    end
  end

  namespace :populate do
    desc "Populate db"
    task :stock => :environment do
      csv_text = File.read('db/data/stock_profiles.csv')
      csv = CSV.parse(csv_text, :headers => true)
      csv.each do |row|
        s = StockTicker.find_by_symbol(row["Stock Symbol"])
        p s.symbol
        s.business_summary  = row["Business Summary"]
        s.sector            = row["Sector"]
        s.industry          = row["Industry"]
        s.url               = row["URL"]
        s.save
      end
    end

    task :fund => :environment do
      csv_text = File.read('db/data/fund_profiles.csv')
      csv = CSV.parse(csv_text, :headers => true)
      csv.each do |row|
        f = FundTicker.find_by_symbol(row["Symbol"])
        p f.symbol
        f.category          = row["Category"]
        f.family            = row["Family"]
        f.inception_date    = row["Inception Date"]
        f.summary           = row["Summary"]
        f.save
      end
    end
  end
end