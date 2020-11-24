class Page < ApplicationRecord
  validates :title, :description, presence: true
end
