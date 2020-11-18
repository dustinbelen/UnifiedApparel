class ProductsController < ApplicationController
  def index
    @np = [] # New products to show in the home page
    Product.includes(:category, :state, :product_images).each do |product|
      @np << product if product.state.name == "New"
    end
  end

  def all_products
    @all_products = Product.includes(:category, :product_images)
  end

  def about; end

  def show
    @product = Product.includes(:category, :state, :product_images, :product_colors, :colors, :product_sizes, :sizes).find(params[:id])
  end
end
