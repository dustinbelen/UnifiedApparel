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
      if quantity > 0 && quantity < 11
        session[:cart_with_options] << {
          id:         id,
          p_color_id: p_color_id,
          p_size_id:  p_size_id,
          quantity:   quantity
        }

        flash[:info] = "Added to cart!"
      else
        flash[:danger] = "The quantity can only be between 1 and 10"
      end
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
      if new_quantity > 0 && new_quantity < 11
        hash_product["p_color_id"] = new_color_id
        hash_product["p_size_id"] = new_size_id
        hash_product["quantity"] = new_quantity

        flash[:info] = "Updated #{new_quantity} - #{Product.find(id).name}, #{Color.find(new_color_id).name}, #{Size.find(new_size_id).code}!"
      else
        flash[:danger] = "The quantity can only be between 1 and 10"
      end
    else
      flash[:danger] = "Cannot update #{new_quantity} - #{Product.find(id).name}, #{Color.find(new_color_id).name}, #{Size.find(new_size_id).code} - it may already exist!"
    end
    redirect_to request.referer
  end

  def checkout; end

  def process_customer_info
    passed_customer_form_validation_checks = true
    form_elements = []
    form_elements << params[:name]
    form_elements << params[:address]
    form_elements << params[:phone_number]
    form_elements << params[:email]
    form_elements << params[:city]
    form_elements << params[:province]
    form_elements << params[:postal_code]

    form_elements.each do |f|
      next unless f == ""

      flash[:danger] = "Do not leave any blank spots! Please fill this out again."
      passed_customer_form_validation_checks = false
      break
    end

    if passed_customer_form_validation_checks == true
      session[:cust_name] = params[:name]
      session[:cust_address] = params[:address]
      session[:cust_phone_number] = params[:phone_number]
      session[:cust_email] = params[:email]
      session[:cust_city] = params[:city]
      session[:cust_province] = params[:province]
      session[:cust_postal_code] = params[:postal_code]

      redirect_to payment_products_path
    else
      redirect_to request.referer
    end
  end

  def payment
    # Calculate Tax Rate
    @subtotal = 0
    session[:cart_with_options].each do |cart|
      product = Product.find(cart["id"])
      @subtotal += product.price * cart["quantity"]
    end

    tax_rates = []
    total_tax_rate = 0
    @total = 0
    @province = Province.find(session[:cust_province].to_i)
    tax_rates << @province.pst if @province.pst != 0
    tax_rates << @province.gst if @province.gst != 0
    tax_rates << @province.hst if @province.hst != 0
    tax_rates << @province.qst if @province.qst != 0

    tax_rates.each do |t|
      total_tax_rate += t
    end

    total_tax_rate = total_tax_rate / 100 + 1
    @total = @subtotal * total_tax_rate
    session[:total] = @total

    # form will submit to process payment
  end

  def process_payment
    # This will add the order to the orders table and customer to the customer table
    order_num = Faker::Number.unique.number(digits: 5)

    customer = Customer.find_or_create_by(name:          session[:cust_name].upcase,
                                          address:       session[:cust_address].upcase,
                                          postal_code:   session[:cust_postal_code].upcase,
                                          phone_number:  session[:cust_phone_number].to_i,
                                          email_address: session[:cust_email].upcase,
                                          city:          session[:cust_city].upcase,
                                          province:      Province.find(session[:cust_province].to_i))
    order = Order.create(order_number: order_num, order_date: DateTime.now, note: nil, total: session[:total], customer: customer)
    session[:cart_with_options].each do |cart_product|
      product = Product.find(cart_product["id"])
      OrderProduct.create(quantity:          cart_product["quantity"].to_i,
                          color:             Color.find(cart_product["p_color_id"]).name,
                          size:              Size.find(cart_product["p_size_id"]).code,
                          price_per_product: product.price,
                          product:           product,
                          order:             order)
    end

    flash[:info] = "Thanks for your order!"
    session[:cart_with_options] = []
    redirect_to root_path
  end
end
