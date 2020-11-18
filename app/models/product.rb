class Product < ApplicationRecord
  belongs_to :category
  belongs_to :state

  has_many :product_images
  accepts_nested_attributes_for :product_images, allow_destroy: true

  has_many :product_colors
  has_many :colors, through: :product_colors
  accepts_nested_attributes_for :product_colors, allow_destroy: true

  has_many :product_sizes
  has_many :sizes, through: :product_sizes
  accepts_nested_attributes_for :product_sizes, allow_destroy: true

  has_many :order_products
  has_many :orders, through: :order_products

  has_many :cart_products
  has_many :carts, through: :cart_products

  validates :name, presence: true
  validates :stock, numericality: { only_integer: true, greater_than: 0 }
  validates :price, numericality: true
end
