class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_items, dependent: :destroy
  has_many :products, through: :order_items

  validates :status, presence: true
  validates :subtotal, :gst_amount, :pst_amount, :hst_amount, :total_amount,
            presence: true, numericality: { greater_than_or_equal_to: 0 }
end