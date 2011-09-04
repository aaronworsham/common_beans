module BackboneHelper
  def render_backbone_templates
    template_directory = Rails.root.join "backbone", "templates", "*.html.handlebars"
    templates = Dir.glob(template_directory).collect { |t| File.read t }    
    raw templates.join("\n")
  end
end
