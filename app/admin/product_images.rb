ActiveAdmin.register ProductImage do
  permit_params :image_filename, :image, :product_id

  index do
    selectable_column
    column :product
    column :image_filename
    column :image do |ad|
      image_tag(ad.image.variant(resize_to_limit: [100, 100])) if ad.image.attached?
    end
    column :created_at
    actions
  end

  show do
    attributes_table do
      row :product
      row :image_filename
      row :image do |ad|
        image_tag(ad.image.variant(resize_to_limit: [100, 100])) if ad.image.attached?
      end
    end
  end

  form do |f|
    f.semantic_errors(*f.object.errors.keys)
    f.inputs "Product Image" do
      f.input :product
      f.input :image_filename
      f.input :image, as: :file
    end
    f.actions
  end
end
