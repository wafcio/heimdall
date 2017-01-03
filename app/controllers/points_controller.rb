class PointsController < ApplicationController
  before_action :admin_require

  def index
    points = Point.by_name
    render locals: { points: points }
  end

  def new
    point = Point.new
    render locals: { point: point }
  end

  def create
    point = Point.new(point_params)

    if point.save
      redirect_to point, notice: "Point was successfully created."
    else
      render :new, locals: { point: point }
    end
  end

  def show
    point = load_point
    render locals: { point: point }
  end

  def edit
    point = load_point
    render locals: { point: point }
  end

  def update
    point = load_point

    if point.update(point_params)
      redirect_to point, notice: "Point was successfully updated."
    else
      render :edit, locals: { point: point }
    end
  end

  def destroy
    point = load_point
    point.destroy

    redirect_to points_url, notice: "Point was successfully destroyed."
  end

  private

  def load_point
    Point.find(params[:id])
  end

  def point_params
    params.fetch(:point, {}).
      permit(:category_id, :name, :latitude, :longitude, :street_name, :street_number, :zip_code, :city, :state, :country)
  end
end
