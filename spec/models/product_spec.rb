require 'rails_helper'

RSpec.describe Product, type: :model do

  it "is a valid product" do
    product = build(:product)
    expect(product).to be_valid
  end


end
