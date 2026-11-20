ActiveAdmin.register Order do
  actions :index, :show

  controller do
    def scoped_collection
      super.includes(customer: :province, order_items: :product)
    end
  end

  index do
    id_column
    column("Customer") do |order|
      "#{order.customer.first_name} #{order.customer.last_name} (#{order.customer.email}) — #{order.customer.province.code}"
    end
    column("Products Ordered") do |order|
      ul do
        order.order_items.each do |item|
          li "#{item.product.title} (x#{item.quantity} @ #{number_to_currency(item.price)})"
        end
      end
    end
    column("Subtotal") { |order| number_to_currency(order.subtotal) }
    column("Taxes") do |order|
      total_tax = order.gst_amount + order.pst_amount + order.hst_amount
      "#{number_to_currency(total_tax)} (GST: #{number_to_currency(order.gst_amount)}, PST: #{number_to_currency(order.pst_amount)}, HST: #{number_to_currency(order.hst_amount)})"
    end
    column("Grand Total") { |order| strong number_to_currency(order.total_amount) }
    column :status
    column :created_at
  end
end