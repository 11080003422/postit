class CategoriesController < ApplicationController
  def show
    @category = Category.find(params[:id])
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