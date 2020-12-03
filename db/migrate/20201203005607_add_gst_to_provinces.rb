class AddGstToProvinces < ActiveRecord::Migration[6.0]
  def change
    add_column :provinces, :gst, :float
  end
end
