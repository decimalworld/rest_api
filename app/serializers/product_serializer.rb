class ProductSerializer < ActiveModel::Serializer
  # cache key: 'post', expires_in: 3.hours
  cache
  delegate :cache_key, to: :object

  attributes :id, :title, :price, :quantity, :published
  has_one :user

  # def cache_key
  #   [object, scope]
  # end
end
