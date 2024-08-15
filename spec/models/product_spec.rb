require 'rails_helper'

RSpec.describe Product, type: :model do

  it "is a valid product" do
    product = build(:product)
    expect(product).to be_valid
  end

  it "is not valid if the product nome, ncm and cfop has already been taken" do

    product = Product.create!(nome:"test",ncm:"12345678",cfop:"5101")
    product_2 = build(:product,nome:"test",ncm:"12345678",cfop:"5101")

    expect(product_2).not_to be_valid
    expect(product_2.errors[:nome]).to include("has already been taken")

  end



end
