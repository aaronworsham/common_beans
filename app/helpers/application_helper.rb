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
    if dir.respond_to?('each')
      array = []
      dir.each do |d|
        array = add_template(d, array)
      end
    else
      array = add_template(dir)
    end
    array.join("\n").html_safe
  end

  def add_template(dir, array = [])
    ::Dir["app/templates/#{dir}/**/*.mustache"].each do |path|
      array << mustache_include_helper(path)
    end
    array
  end
end
