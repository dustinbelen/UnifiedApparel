ActiveAdmin.register Product do
  permit_params :name, :stock, :description, :price, :category_id, :state_id, :product_image_id, product_sizes_attributes: %i[id product_id size_id _destroy], product_colors_attributes: %i[id product_id color_id _destroy]

  controller do
    def scoped_collection
      super.includes :product_sizes, :sizes, :product_colors, :colors, :state, :category, :product_images
    end
  end

  index do
    selectable_column
    column :id
    column :name
    column :stock
    column :description
    column :price do |p|
      number_to_currency(p.price)
    end
    column :category
    column :state
    column :colors do |product|
      product.colors.map { |c| c.name }.join(", ").html_safe
    end
    column :sizes do |product|
      product.sizes.map { |c| c.code }.join(", ").html_safe
    end
    column :product_images do |product|
      product.product_images.map do |i|
        image_tag(i.image.variant(resize_to_limit: [100, 100])) if i.image.attached?
      end
    end
    actions
  end

  show do
    attributes_table do
      row :name
      row :stock
      row :description
      row :price
      row :category
      row :state
      row :colors do |product|
        product.colors.map { |c| c.name }.join(", ").html_safe
      end
      row :sizes do |product|
        product.sizes.map { |c| c.code }.join(", ").html_safe
      end
      row :product_images do |product|
        product.product_images.map do |i|
          image_tag(i.image.variant(resize_to_limit: [100, 100])) if i.image.attached?
        end
      end
    end
  end

  form do |f|
    f.semantic_errors(*f.object.errors.keys)

    f.inputs "Product" do
      f.input :name
      f.input :stock
      f.input :description
      f.input :price
      f.input :category
      f.input :state
      f.has_many :product_colors, allow_destroy: true do |n_f|
        n_f.input :color
      end
      f.has_many :product_sizes, allow_destroy: true do |n_f|
        n_f.input :size, collection: Size.all.collect { |size| [size.code, size.id] }
      end
    end

    f.actions
  end
end
