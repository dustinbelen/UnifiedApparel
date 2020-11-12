class Customer < ApplicationRecord
  belongs_to :province
  has_many :orders

  has_one :customer_account
  has_one :account, through: :customer_account

  validates :name, presence: true, length: { minimum: 5, maximum: 30 }
  validates :address, presence: true, length: { minimum: 5, maximum: 50 }
  validates :postal_code, presence: true, length: { minimum: 6, maximum: 7 }
  validates :phone_number, presence: true, numericality: { only_integer: true }
  validates :email_address, presence: true, length: { minimum: 5, maximum: 100 }
end
