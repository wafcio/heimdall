module ApplicationHelper
  def website_title
    ENV["WEBSITE_TITLE"].present? ? ENV["WEBSITE_TITLE"] : "Heimdall"
  end
end
