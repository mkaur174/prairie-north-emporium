class Page < ApplicationRecord
  validates :title, presence: true, length: { minimum: 2, maximum: 150 }
  validates :slug, presence: true, uniqueness: true, format: { with: /\A[a-z0-9-]+\z/ }
  validates :content, presence: true, length: { minimum: 10 }
end
