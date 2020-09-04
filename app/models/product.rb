class Product < ApplicationRecord
  validate :title, :user_id, presence: true
  validate :price, numericality: { greater_than_or_equal_to: 0 }, presence: true
end
