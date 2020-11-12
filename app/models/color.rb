class Color < ApplicationRecord
  has_many :product_colors

  validates :name, presence: true
end
