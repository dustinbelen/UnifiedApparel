class CreateOrderProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :order_products do |t|
      t.integer :quantity
      t.string :color
      t.string :size
      t.float :price_per_product
      t.references :product, null: false, foreign_key: true
      t.references :order, null: false, foreign_key: true

      t.timestamps
    end
  end
end
