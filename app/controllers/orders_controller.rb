class OrdersController < ApplicationController
  def new
    if session[:cart].blank?
      redirect_to cart_path, alert: "Your shopping cart is empty."
      return
    end

    @customer = Customer.new
    @provinces = Province.order(:name)
    @cart_items, @subtotal = build_cart_summary
  end

  def create
    @provinces = Province.order(:name)
    @cart_items, @subtotal = build_cart_summary

    @customer = Customer.new(customer_params)
    if @customer.save
      province = @customer.province
      gst = (@subtotal * province.gst).round(2)
      pst = (@subtotal * province.pst).round(2)
      hst = (@subtotal * province.hst).round(2)
      total = (@subtotal + gst + pst + hst).round(2)

      @order = @customer.orders.create!(
        status: "pending",
        subtotal: @subtotal,
        gst_amount: gst,
        pst_amount: pst,
        hst_amount: hst,
        total_amount: total
      )

      @cart_items.each do |item|
        @order.order_items.create!(
          product: item[:product],
          quantity: item[:quantity],
          price: item[:product].price
        )
      end

      session[:cart] = {}
      redirect_to order_path(@order), notice: "Order placed successfully! Review your tax invoice below."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @order = Order.includes(customer: :province, order_items: :product).find(params[:id])
  end

  private

  def customer_params
    params.require(:customer).permit(:first_name, :last_name, :email, :phone, :street_address, :city, :postal_code, :province_id)
  end

  def build_cart_summary
    items = []
    subtotal = 0
    session[:cart].each do |product_id, qty|
      product = Product.find_by(id: product_id)
      next unless product

      line_total = product.price * qty.to_i
      subtotal += line_total
      items << { product: product, quantity: qty.to_i, line_total: line_total }
    end
    [items, subtotal]
  end
end