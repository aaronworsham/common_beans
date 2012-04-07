module DashboardHelper

  def securities_form_loader_helper
    html = []
    ::Dir["app/views/securities/**/*.haml"].each do |path|
      html << render(:file => path)
    end
    html.join("/n").html_safe
  end
end
