class CategoriesController < ApplicationController
  before_action :admin_require

  def index
    categories = Category.sort_by_name
    render locals: { categories: categories }
  end

  def new
    category = Category.new
    render locals: { category: category }
  end

  def create
    category = Category.new(category_params)
    if category.save
      redirect_to categories_url, notice: "Category created"
    else
      render :new, locals: { category: category }
    end
  end

  def edit
    category = Category.find(params[:id])
    render locals: { category: category }
  end

  def update
    category = Category.find(params[:id])
    if category.update(category_params)
      redirect_to categories_url, notice: "Category updated"
    else
      render :edit, locals: { category: category }
    end
  end

  def destroy
    category = Category.find(params[:id])
    if category.points.exists?
      flash[:alert] = "Category cannot be destroyed"
    else
      flash[:notice] = "Category destroyed"
      category.destroy
    end
    redirect_to categories_url
  end

  private

  def category_params
    params.fetch(:category, {}).permit(:name, :image, :image_cache)
  end
end
