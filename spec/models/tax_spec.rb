require 'rails_helper'

RSpec.describe Tax, type: :model do

  it "is a valid tax" do
    product = build(:tax)
    expect(product).to be_valid
  end
end
