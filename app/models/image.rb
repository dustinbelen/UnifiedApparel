class Image < ApplicationRecord
  belongs_to :product

  validates :name, :path, presence: true
end
