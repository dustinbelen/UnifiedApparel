class CreateProductImages < ActiveRecord::Migration[6.0]
  def change
    create_table :product_images do |t|
      t.string :image_filename
      t.binary :image, limit: 10.megabyte
      t.references :product, null: false, foreign_key: true

      t.timestamps
    end
  end
end
