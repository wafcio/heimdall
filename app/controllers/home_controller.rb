class HomeController < ApplicationController
  def index
    points = Point.includes(:category, :images)
    render locals: { points: points }
  end
end
