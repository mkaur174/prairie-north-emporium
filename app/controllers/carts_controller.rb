class CartsController < ApplicationController
  def show
    @cart_items = []
    @subtotal = 0

    session[:cart].each do |product_id, quantity|
      product = Product.find_by(id: product_id)
      next unless product

      line_total = product.price * quantity.to_i
      @subtotal += line_total
      @cart_items << { product: product, quantity: quantity.to_i, line_total: line_total }
    end
  end

  def add
    id = params[:product_id].to_s
    session[:cart][id] = (session[:cart][id] || 0) + 1
    redirect_back fallback_location: root_path, notice: "Added item to your shopping cart."
  end

  def update
    id = params[:product_id].to_s
    qty = params[:quantity].to_i

    if qty > 0
      session[:cart][id] = qty
      redirect_to cart_path, notice: "Item quantity updated."
    else
      session[:cart].delete(id)
      redirect_to cart_path, notice: "Item removed from shopping cart."
    end
  end

  def remove
    session[:cart].delete(params[:product_id].to_s)
    redirect_to cart_path, notice: "Item removed from shopping cart."
  end
end