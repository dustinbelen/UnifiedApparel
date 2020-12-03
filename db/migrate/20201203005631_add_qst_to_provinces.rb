class AddQstToProvinces < ActiveRecord::Migration[6.0]
  def change
    add_column :provinces, :qst, :float
  end
end
