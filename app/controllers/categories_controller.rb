class CategoriesController < ApplicationController
  before_action :logged_in?, only: [:new, :create]
  before_action :require_user, except: [:show]

  def show
    @category = Category.find_by_slug(params[:id])
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new category_params

    if @category.save
      flash[:notice] = 'Category successfully created'
      redirect_to posts_path
    else
      render 'categories/new'
    end
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end