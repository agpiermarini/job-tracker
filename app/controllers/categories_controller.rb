class CategoriesController < ApplicationController
  def index
    @categories = Category.by_name
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
    if params[:sort]
      @jobs = Job.by_category(params[:id], params[:sort])
    else
      @jobs = Job.by_category(params[:id])
    end
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    @category.update(category_params)
    if @category.save
      flash[:success] = "Category title changed to #{@category.title}"
      redirect_to categories_path
    else
      flash[:success] = "Failed to update category"
      redirect_to edit_category_path(@category)
    end
  end

  def destroy
    @category = Category.find(params[:id])
    if @category.destroy
      flash[:success] = "#{@category.title} deleted"
      redirect_to categories_path
    else
      flash[:success] = "Failed to delete category"
      redirect_to edit_category_path(@category)
    end
  end

  private

  def category_params
    params.require(:category).permit(:title)
  end
end
