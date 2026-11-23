ActiveAdmin.register Product do
  permit_params :title, :description, :price, :stock_quantity, :category_id, :image

  index do
    selectable_column
    id_column
    column("Image") do |product|
      if product.image.attached?
        image_tag product.image.variant(resize_to_limit: [60, 60])
      else
        "No image"
      end
    end
    column :title
    column :category
    column :price
    column :stock_quantity
    column :updated_at
    actions
  end

  form do |f|
    f.inputs "Product Details" do
      f.input :category
      f.input :title
      f.input :description
      f.input :price
      f.input :stock_quantity
      f.input :image, as: :file, hint: (f.object.image.attached? ? image_tag(f.object.image.variant(resize_to_limit: [150, 150])) : "Upload a product photo")
    end
    f.actions
  end

  show do
    attributes_table do
      row :id
      row :category
      row :title
      row :description
      row :price
      row :stock_quantity
      row :image do |product|
        image_tag product.image.variant(resize_to_limit: [300, 300]) if product.image.attached?
      end
      row :created_at
      row :updated_at
    end
  end
end