class Account < ApplicationRecord
  belongs_to :customer

  has_one :cart, through: :account_cart
  has_one :account_cart

  validates :username, :password, presence: true, length: { minimum: 6, maximum: 12 }
end
