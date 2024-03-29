class Cart < ApplicationRecord
  belongs_to :account

  has_many :cart_products
  has_many :products, through: :cart_products
end
