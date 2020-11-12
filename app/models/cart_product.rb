class CartProduct < ApplicationRecord
  belongs_to :cart
  belongs_to :product

  validates :quantity, presence: true, numericality: { integer_only: true }
  validates :color, :size, presence: true
end
