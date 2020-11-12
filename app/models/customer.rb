class Customer < ApplicationRecord
  belongs_to :province
  has_many :orders

  has_one :account, through: :customer_accounts
  has_one :customer_account
end
