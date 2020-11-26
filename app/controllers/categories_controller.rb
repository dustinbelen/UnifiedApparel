class CategoriesController < ApplicationController
  def index
    @categories = Category.includes(:products)
  end

  def show
    @category = Category.includes(:products).find(params[:id])
  end

  def search
    @searched_products = []
    if params[:select_category] == ""
      @query = Product.where("name LIKE ?", "%#{params[:search_product]}%")
      @query.each do |qp|
        @searched_products << qp
      end
    else
      @category_selected = Category.find(params[:select_category].to_i)
      @query = @category_selected.products.where("name LIKE ?", "%#{params[:search_product]}%")
      @query.each do |qp|
        @searched_products << qp
      end
    end
  end
end
