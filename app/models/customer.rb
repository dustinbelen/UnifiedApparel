class Customer < ApplicationRecord
  belongs_to :province

  has_many :orders, dependent: :delete_all
  accepts_nested_attributes_for :orders, allow_destroy: true

  # implementation pending: not yet sure if this will be done or not
  has_one :customer_account
  has_one :account, through: :customer_account

  validates :name, presence: true, length: { minimum: 5, maximum: 30 }
  validates :address, presence: true, length: { minimum: 5, maximum: 50 }
  validates :postal_code, presence: true, length: { minimum: 6, maximum: 7 }
  validates :phone_number, presence: true, numericality: { only_integer: true }
  validates :email_address, presence: true, length: { minimum: 5, maximum: 100 }
end
