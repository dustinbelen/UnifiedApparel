class CategoriesController < ApplicationController
  def index
    @categories = Category.includes(:products)
  end

  def show
    @category = Category.includes(:products).find(params[:id])
  end
end
