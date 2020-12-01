class ApplicationController < ActionController::Base
  before_action :initialize_session
  add_flash_types :info, :danger

  private

  def initialize_session
    session[:cart_with_options] ||= []
  end
end
