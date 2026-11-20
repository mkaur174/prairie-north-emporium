class Customer < ApplicationRecord
  belongs_to :province
  has_many :orders, dependent: :destroy

  validates :first_name, :last_name, :email, :street_address, :city, :postal_code, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
end