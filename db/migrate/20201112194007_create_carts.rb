class CreateCarts < ActiveRecord::Migration[6.0]
  def change
    create_table :carts do |t|
      t.float :subtotal
      t.references :account, null: false, foreign_key: true

      t.timestamps
    end
  end
end
