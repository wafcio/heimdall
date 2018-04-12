module ApplicationHelper
  def website_title
    ENV["WEBSITE_TITLE"].present? ? ENV["WEBSITE_TITLE"] : "Heimdall"
  end

  def formatted_description(point)
    point.description.to_s.gsub("\n", "<br>")
  end
end
