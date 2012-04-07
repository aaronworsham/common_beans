module ApplicationHelper
  def mustache_include_helper(path)
    exploded = path.split("/")
    file = exploded.pop
    file = file.split(".").first
    file = file[1..-1]
    template = ::File.open(path, "rb")
    content_tag(:script, template.read.html_safe, :type => "text/html", :id => "#{file.dasherize.underscore}_template")
  end

  def template_include_path_helper(dir)
    html = []
    ::Dir["app/templates/#{dir}/**/*.mustache"].each do |path|
      html << mustache_include_helper(path)
    end
    html.join("\n").html_safe
  end
end
