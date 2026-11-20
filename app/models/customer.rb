class Customer < ApplicationRecord
  belongs_to :province
  has_many :orders, dependent: :destroy

  validates :first_name, :last_name, presence: true,
            format: { with: /\A[a-zA-Z\s'-]+\z/, message: "only allows letters, spaces, hyphens, and apostrophes" }
  validates :email, presence: true,
            format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i, message: "must be a valid email address (e.g. name@example.com)" }
  validates :phone, allow_blank: true,
            format: { with: /\A(\+?1[-.\s]?)?\(?\d{3}\)?[-.\s]?\d{3}[-.\s]?\d{4}\z/, message: "must be a valid 10-digit phone number" }
  validates :street_address, presence: true, length: { minimum: 5 }
  validates :city, presence: true,
            format: { with: /\A[a-zA-Z\s.-]+\z/, message: "only allows letters" }
  validates :postal_code, presence: true,
            format: { with: /\A[A-Za-z]\d[A-Za-z][ -]?\d[A-Za-z]\d\z/, message: "must be a valid Canadian postal code (e.g. R3B 1K7)" }
end