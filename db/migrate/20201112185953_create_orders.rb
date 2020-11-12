class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.integer :order_number
      t.timestamp :order_date
      t.text :note
      t.float :total
      t.references :customer, null: false, foreign_key: true

      t.timestamps
    end
  end
end
