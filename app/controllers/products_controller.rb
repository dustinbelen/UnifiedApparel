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

  def show
    @product = Product.includes(:category, :state, :product_images, :product_colors, :colors, :product_sizes, :sizes).find(params[:id])
  end

  def filter
    @filtered_products = []
    if params[:selected_state] == ""
      @query = Product.includes(:category, :product_images)
      @query.each do |qp|
        @filtered_products << qp
      end
    else
      @state_to_filter = State.find(params[:selected_state].to_i)
      @state_to_filter.products.each do |sp|
        @filtered_products << sp
      end
    end
  end
end
