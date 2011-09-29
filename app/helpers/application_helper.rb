module ApplicationHelper
  def mustache_include_tag(*sources)
    sources.collect do |source|
      exploded = source.split("/")
      file = exploded.pop
      file = file.split(".").first
      template_path = ::Rails.root.join('app/views', *exploded, "_#{file}.html.mustache")
      template = ::File.open(template_path, "rb")
      content_tag(:script, template.read.html_safe, :type => "text/html", :id => "#{file.dasherize.underscore}_template")
    end.join("\n").html_safe
  end

end
