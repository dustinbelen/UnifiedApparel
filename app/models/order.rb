class Order < ApplicationRecord
  belongs_to :customer

  has_many :order_products
  has_many :products, through: :order_products

  validates :order_number, presence: true, length: {minimum: 5}
end
