class Size < ApplicationRecord
  has_many :product_sizes

  validates :code, presence: true
end
