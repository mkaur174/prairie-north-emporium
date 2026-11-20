class ProductsController < ApplicationController
  def index
    @categories = Category.order(:name)
    @products = Product.includes(:category).order(:title)

    case params[:filter]
    when "new"
      @products = @products.new_arrivals
    when "updated"
      @products = @products.recently_updated
    end

    if params[:category_id].present?
      @products = @products.where(category_id: params[:category_id])
    end

    if params[:keyword].present?
      term = "%#{params[:keyword].strip}%"
      @products = @products.where("title LIKE ? OR description LIKE ?", term, term)
    end

    @products = @products.page(params[:page]).per(12)
  end

  def show
    @product = Product.find(params[:id])
  end
end