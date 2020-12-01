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

  def cart; end

  def add_to_cart
    id = params[:id].to_i
    p_color_id = params[:color_selected].to_i
    p_size_id = params[:size_selected].to_i
    quantity = params[:quantity].to_i

    find_a_dupe = session[:cart_with_options].find { |h| h["id"] == id && h["p_color_id"] == p_color_id && h["p_size_id"] == p_size_id && h["quantity"] == quantity }

    if find_a_dupe.nil?
      session[:cart_with_options] << {
        id:         id,
        p_color_id: p_color_id,
        p_size_id:  p_size_id,
        quantity:   quantity
      }

      flash[:info] = "Added to cart!"
    else
      flash[:danger] = "This is already in your cart!"
    end

    redirect_to request.referer
  end

  def remove_from_cart
    id = params[:id].to_i
    p_color_id = params[:p_color_id].to_i
    p_size_id = params[:p_size_id].to_i
    quantity = params[:quantity].to_i

    index = session[:cart_with_options].index { |h| h["id"] == id && h["p_color_id"] == p_color_id && h["p_size_id"] == p_size_id && h["quantity"] == quantity }

    session[:cart_with_options].delete_at(index.to_i)

    flash[:info] = "Removed #{quantity} - #{Product.find(id).name}, #{Color.find(p_color_id).name}, #{Size.find(p_size_id).code} from the cart!"

    redirect_to request.referer
  end

  def update_from_cart
    id = params[:id].to_i
    p_color_id = params[:p_color_id].to_i
    p_size_id = params[:p_size_id].to_i
    quantity = params[:quantity].to_i

    new_color_id = params[:new_color].to_i
    new_size_id = params[:new_size].to_i
    new_quantity = params[:new_quantity].to_i

    hash_product = session[:cart_with_options].find { |h| h["id"] == id && h["p_color_id"] == p_color_id && h["p_size_id"] == p_size_id && h["quantity"] == quantity }

    find_a_dupe = session[:cart_with_options].find { |h| h["id"] == id && h["p_color_id"] == new_color_id && h["p_size_id"] == new_size_id && h["quantity"] == new_quantity }

    if find_a_dupe.nil?
      hash_product["p_color_id"] = new_color_id
      hash_product["p_size_id"] = new_size_id
      hash_product["quantity"] = new_quantity

      flash[:info] = "Updated #{new_quantity} - #{Product.find(id).name}, #{Color.find(new_color_id).name}, #{Size.find(new_size_id).code}!"
    else
      flash[:danger] = "Cannot update #{new_quantity} - #{Product.find(id).name}, #{Color.find(new_color_id).name}, #{Size.find(new_size_id).code} - it may already exist!"
    end

    redirect_to request.referer
  end
end
