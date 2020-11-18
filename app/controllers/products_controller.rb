class ProductsController < ApplicationController
  def index
    @np = [] # New products to show in the home page
    Product.includes(:category, :state).each do |product|
      @np << product if product.state.name == "New"
    end
  end

  def all_products
    @all_products = Product.includes(:category)
  end

  def about; end
end
