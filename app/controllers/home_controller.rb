class HomeController < ApplicationController
  def index
    points = Point.includes(:category)
    render locals: { points: points }
  end
end
