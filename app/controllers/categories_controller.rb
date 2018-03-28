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
      flash[:success] = "Created the #{@category.title} Category"
      redirect_to category_path(@category)
    else
      flash[:success] = "Failed to create category"
      redirect_to new_category_path
    end
  end

  def show
    @category = Category.find(params[:id])
    @jobs = Job.by_category(params[:id])
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    @category.update(category_params)
    if @category.save
      flash[:success] = "Updated category title to #{@category.title}"
      redirect_to categories_path
    else
      flash[:success] = "Failed to update category"
      render :edit
    end
  end

  def destroy
    @category = Category.find(params[:id])
    if @category.destroy
      flash[:success] = "Deleted #{@category.title} deleted"
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
