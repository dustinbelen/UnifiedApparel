class Product < ApplicationRecord
  belongs_to :category
  belongs_to :state

  has_many :images

  has_many :product_colors
  has_many :colors, through: :product_colors

  has_many :product_sizes
  has_many :sizes, through: :product_sizes

  has_many :order_products
  has_many :orders, through: :order_products

  has_many :cart_products
  has_many :carts, through: :cart_products

  validates :name, presence: true
  validates :stock, numericality: { only_integer: true, greater_than: 0 }
end
