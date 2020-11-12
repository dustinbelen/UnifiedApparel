class CustomerAccount < ApplicationRecord
  belongs_to :customer
  belongs_to :account
end
