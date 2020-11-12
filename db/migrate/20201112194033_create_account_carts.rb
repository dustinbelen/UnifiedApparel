class CreateAccountCarts < ActiveRecord::Migration[6.0]
  def change
    create_table :account_carts do |t|
      t.references :account, null: false, foreign_key: true
      t.references :cart, null: false, foreign_key: true

      t.timestamps
    end
  end
end
