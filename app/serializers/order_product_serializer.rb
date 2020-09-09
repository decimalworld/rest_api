class OrderProductSerializer < OrderSerializer
  def include_user?
    false
  end
end
