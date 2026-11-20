ActiveAdmin.register Product do
  permit_params :title, :description, :price, :stock_quantity, :category_id

  index do
    selectable_column
    id_column
    column :title
    column :category
    column :price
    column :stock_quantity
    actions
  end

  form do |f|
    f.inputs "Product Details" do
      f.input :category
      f.input :title
      f.input :description
      f.input :price
      f.input :stock_quantity
    end
    f.actions
  end
end