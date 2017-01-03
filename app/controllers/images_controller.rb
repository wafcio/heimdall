class ImagesController < ApplicationController
  before_action :admin_require

  def create
    image = Image.new(image_params)
    image.save
    redirect_to :back
  end

  def destroy
    image = Image.find(params[:id])
    image.destroy
    redirect_to :back
  end

  private

  def image_params
    params.fetch(:image, {}).permit(:point_id, :file, :file_cache)
  end
end
