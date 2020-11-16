class ProductsController < ApplicationController
  def index
    @products = Product.includes(:category, :state)
  end

  def all_products
    @all_products = Product.includes(:category)
  end

  def about; end
end
