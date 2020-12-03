class Order < ApplicationRecord
  belongs_to :customer

  has_many :order_products, dependent: :nullify
  has_many :products, through: :order_products
  accepts_nested_attributes_for :order_products, allow_destroy: true

  validates :order_number, presence: true, length: { minimum: 5 }
end
