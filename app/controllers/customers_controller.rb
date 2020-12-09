class CustomersController < ApplicationController
  def create
    customer = Customer.find { |i| i.email_address == current_user.email.upcase }
    unless customer.nil?
      session[:c_name] = customer.name
      session[:c_address] = customer.address
      session[:c_phone_number] = customer.phone_number
      session[:c_city] = customer.city
      session[:c_province] = customer.province
      session[:c_postal_code] = customer.postal_code
      session[:c_email] = current_user.email
    end
  end

  def process_account_information
    customer = Customer.find { |i| i.email_address == current_user.email.upcase }
    if customer.nil?
      passed_customer_form_validation_checks = true
      form_elements = []
      form_elements << params[:name]
      form_elements << params[:address]
      form_elements << params[:phone_number]
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
        new_cust = Customer.find_or_create_by(name:          params[:name].upcase,
                                              address:       params[:address].upcase,
                                              postal_code:   params[:postal_code].upcase,
                                              phone_number:  params[:phone_number].to_i,
                                              email_address: current_user.email.upcase,
                                              city:          params[:city].upcase,
                                              province:      Province.find(params[:province].to_i))

        flash[:info] = new_cust.errors.full_messages
      end
    else
      # update customer
      Customer.update(customer.id,
                      name:          params[:name].upcase,
                      address:       params[:address].upcase,
                      postal_code:   params[:postal_code].upcase,
                      phone_number:  params[:phone_number].to_i,
                      email_address: current_user.email.upcase,
                      city:          params[:city].upcase,
                      province:      Province.find(params[:province].to_i))
      flash[:info] = "Successfully updated your information!"
    end
    redirect_to request.referer
  end
end
