class CategoriesController < ApplicationController
  def index

  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:success] = "You created the #{@category.title} Category"
      redirect_to category_path(@category)
    else
      flash[:success] = "Failed to create category"
      redirect_to new_category_path
    end
  end

  def show
    @category = Category.find(params[:id])
  end

  def edit

  end

  def update

  end

  def destroy

  end

  private

  def category_params
    params.require(:category).permit(:title)
  end
end
