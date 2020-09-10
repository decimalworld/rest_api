class OrderSerializer < ActiveModel::Serializer
  attributes :id, :total
  has_many :placements, serializer: PlacementSerializer
end
