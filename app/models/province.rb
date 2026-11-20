class Province < ApplicationRecord
  has_many :customers, dependent: :restrict_with_error

  validates :name, :code, presence: true, uniqueness: true
  validates :gst, :pst, :hst, presence: true, numericality: { greater_than_or_equal_to: 0 }
end