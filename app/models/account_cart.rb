class AccountCart < ApplicationRecord
  belongs_to :account
  belongs_to :cart
end
