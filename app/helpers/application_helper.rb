module ApplicationHelper
  def website_title
    ENV["WEBSITE_TITLE"].presence || "Heimdall"
  end

  def formatted_description(point)
    point.description.to_s.gsub("\n", "<br>")
  end
end
