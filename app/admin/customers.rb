ActiveAdmin.register Customer do
  permit_params :name, :address, :city, :postal_code, :phone_number, :email_address, :province_id, :order_id

  controller do
    def scoped_collection
      super.includes :orders
    end
  end

  index do
    selectable_column
    column :name
    column :address
    column :city
    column :postal_code
    column :phone_number
    column :email_address
    column :province_id
    column :orders do |c|
      c.orders.map do |i|
        link_to i.order_number, admin_order_path(i)
      end
    end
    actions
  end

  show do
    attributes_table do
      row :name
      row :address
      row :city
      row :postal_code
      row :phone_number
      row :email_address
      row :province_id
      row :orders do |c|
        c.orders.map do |i|
          link_to i.order_number, admin_order_path(i)
        end
      end
    end
  end

  form do |f|
    f.semantic_errors(*f.object.errors.keys)

    f.inputs "Customer" do
      f.input :name
      f.input :address
      f.input :city
      f.input :postal_code
      f.input :phone_number
      f.input :email_address
      f.input :province_id
    end

    f.actions
  end
end
