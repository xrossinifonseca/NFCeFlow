require 'rails_helper'

RSpec.describe Upload, type: :model do

  it "is a valid upload" do

  upload = build(:upload)
  expect(upload).to be_valid
  end



end
