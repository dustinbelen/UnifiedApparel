ActiveAdmin.register OrderProduct do
  permit_params :quantity, :color, :size, :price_per_product, :product_id, :order_id

  index do
    selectable_column
    column :product_id do |o|
      Product.find(o.product_id).name
    end
    column :order_id do |o|
      link_to Order.find(o.order_id).order_number, admin_order_path(o.order_id)
    end
    column :price_per_product do |o|
      number_to_currency(o.price_per_product)
    end
    column :size
    column :color
    column :quantity
    actions
  end

  show do
    attributes_table do
      row :product_id
      row :order_id
      row :price_per_product
      row :size
      row :color
      row :quantity
    end
  end

  form do |f|
    f.semantic_errors(*f.object.errors.keys)

    f.inputs "Order Details" do
      f.input :product_id
      f.input :order_id
      f.input :price_per_product
      f.input :size
      f.input :color
      f.input :quantity
    end

    f.actions
  end
end
