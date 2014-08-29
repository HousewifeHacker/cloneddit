module SubsHelper
  def short_description description
    return "" if description.nil?
    
    html = "<p>"
    if description.length > 140
      html += description[0..140] + "..."
    else
      html += description
    end
    html += "</p>"
    
    html.html_safe
  end
end
