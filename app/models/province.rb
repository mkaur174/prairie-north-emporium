class Province < ApplicationRecord
  has_many :customers, dependent: :restrict_with_error

  validates :name, presence: true, uniqueness: true, format: { with: /\A[a-zA-Z\s]+\z/ }
  validates :code, presence: true, uniqueness: true, length: { is: 2 }, format: { with: /\A[A-Z]{2}\z/ }
  validates :gst, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :pst, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :hst, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
