class CategoriesController < ApplicationController
  def index
    @categories = Category.includes(:products)
  end

  def show
    @category = Category.includes(:products).find(params[:id])
  end

  def search
    @searched_categories = Category.includes(:products).where("name LIKE ?", "%#{params[:search_term]}%")
  end
end
