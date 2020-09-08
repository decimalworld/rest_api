require 'rails_helper'

RSpec.describe Api::V1::OrdersController do

  describe "GET #index" do
    before(:each) do
      current_user = FactoryBot.create :user
      api_authorization_header current_user.auth_token
      4.times { FactoryBot.create :order, user: current_user }
      get :index, params: {user_id: current_user.id}
    end

    it "returns 4 order records from the user" do
      orders_response = json_response[:data]
      expect(orders_response).to have(4).items
    end

    it { should respond_with 200 }
  end
  describe "GET #show" do
    before(:each) do
      current_user = FactoryBot.create :user
      api_authorization_header current_user.auth_token
      @order = FactoryBot.create :order, user: current_user
      get :show, params: {user_id: current_user.id, id:@order.id}
    end
    
    it "returns the user order record matching the id" do
      order_response = json_response[:data]
      expect(order_response[:id]).to eql @order.id.to_s
    end

    it { should respond_with 200 }
  end

  describe "POST #create" do
    before(:each) do
      current_user = FactoryBot.create :user
      api_authorization_header current_user.auth_token
      
      product_1 = FactoryBot.create :product
      product_2 = FactoryBot.create :product
      order_params = { product_ids: [product_1.id, product_2.id] }
        post :create, params: {user_id: current_user.id, order: order_params}
    end

    it "returns just the user order record" do
      order_response = json_response[:data]
      expect(order_response[:id]).to be_present
    end

    it { should respond_with 201 }
  end

  describe '#set_total!' do
    before(:each) do
      product_1 = FactoryBot.create :product, price: 100
      product_2 = FactoryBot.create :product, price: 85

      @order = FactoryBot.create :order, product_ids: [product_1.id,product_2.id]
    end

    it "returns the total amount to pay for the products" do
      expect{@order.set_total!}.to change{@order.total}.from(0).to(185)
    end

end
