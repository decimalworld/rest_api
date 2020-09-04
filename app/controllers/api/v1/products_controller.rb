class Api::V1::ProductsController < ApplicationController
  respond_to :json

  def index
    products = {products: Product.all}
    respond_with products
  end

  def show
    respond_with Product.find(params[:id])
  end
end
