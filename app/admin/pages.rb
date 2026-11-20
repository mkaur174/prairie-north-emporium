ActiveAdmin.register Page do
  actions :index, :show, :edit, :update
  permit_params :title, :content

  index do
    column :title
    column :slug
    column :updated_at
    actions
  end

  form do |f|
    f.inputs "Edit Page Content" do
      f.input :title
      f.input :content, as: :text, input_html: { rows: 10 }
    end
    f.actions
  end
end