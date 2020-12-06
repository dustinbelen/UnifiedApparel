ActiveAdmin.register Order do
  permit_params :order_number, :order_date, :note, :total, :customer_id, order_products_attributes: %i[id product_id order_id _destroy]

  controller do
    def scoped_collection
      super.includes :order_products, :products
    end
  end

  index do
    selectable_column
    column :id
    column :order_number
    column :order_date
    column :note
    column :total
    column :customer
    column :products do |order|
      order.products.map { |p| p.name }.join(", ").html_safe
    end
    actions
  end

  show do
    attributes_table do
      row :id
      row :order_number
      row :order_date
      row :note
      row :total
      row :customer
      row :products do |order|
        order.products.map { |p| p.name }.join(", ").html_safe
      end
    end
  end

  form do |f|
    f.semantic_errors(*f.object.errors.keys)

    f.inputs "Order" do
      f.input :order_number
      f.input :order_date
      f.input :note
      f.input :total
      f.input :customer
      f.has_many :order_products, allow_destroy: true do |n_f|
        n_f.input :product
      end
    end

    f.actions
  end
end
