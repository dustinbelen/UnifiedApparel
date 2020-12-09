class OrdersController < ApplicationController
  def all_orders
    customer = Customer.where("email_address = ?", current_user.email.upcase)
    @orders = []
    customer.each do |c|
      c.orders.each do |o|
        @orders << o
      end
    end
  end

  def show; end
end
