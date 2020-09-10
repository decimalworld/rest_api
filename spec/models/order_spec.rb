require 'rails_helper'
require 'spec_helper'

RSpec.describe Order, type: :model do
  let(:order) { FactoryBot.build :order }
  subject { order }

  it { should respond_to(:total) }
  it { should respond_to(:user_id) }

  it { should belong_to :user }

  it { should have_many(:placements) }
  it { should have_many(:products).through(:placements) }

  # describe '#set_total!' do
  #   before(:each) do

  #     @product_1 = FactoryBot.create :product, price: 100
  #     @product_2 = FactoryBot.create :product, price: 85

  #     @order = FactoryBot.create :order, product_ids: [@product_1.id,@product_2.id]
  #   end

  #   it "returns the total amount to pay for the products" do
  #     expect{@order.total}.to eql(@product_1.price + @product_2.price).to_s
  #   end

  # end  

  describe "#build_placements_with_product_ids_and_quantities" do
    before(:each) do
      product_1 = FactoryBot.create :product, price: 100, quantity: 5
      product_2 = FactoryBot.create :product, price: 85, quantity: 10
      
      @product_ids_and_quantities = [[product_1.id, 2], [product_2.id, 3]]
    end

    it "builds 2 placements for the order" do
      expect{order.build_placements_with_product_ids_and_quantities(@product_ids_and_quantities)}.to change{order.placements.size}.from(0).to(2)
    end
  end

end
