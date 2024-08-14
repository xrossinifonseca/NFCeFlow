require 'rails_helper'

RSpec.describe Nfce, type: :model do

  it 'is a valid nfce' do

    nfce = build(:nfce)
    expect(nfce).to be_valid

  end

  describe "validations" do

    it 'is invalid with no issuer' do
        nfce = build(:nfce, issuer:nil)
        expect(nfce).not_to be_valid
        expect(nfce.errors[:issuer]).to include("must exist")
    end

    it 'is invalid with no recipient' do
      nfce = build(:nfce, recipient:nil)
      expect(nfce).not_to be_valid
      expect(nfce.errors[:recipient]).to include("must exist")
  end

  it 'is invalid with no data de emissão' do
    nfce = build(:nfce, data_emissao:nil)
    expect(nfce).not_to be_valid
    expect(nfce.errors[:data_emissao]).to include("can't be blank")
  end

  it 'is invalid with no número' do
  nfce = build(:nfce, numero_nota:nil)
  expect(nfce).not_to be_valid
  expect(nfce.errors[:numero_nota]).to include("can't be blank")
  end

  it 'is invalid with no serie' do
    nfce = build(:nfce, serie:nil)
    expect(nfce).not_to be_valid
    expect(nfce.errors[:serie]).to include("can't be blank")
    end



  end


  describe "associations" do

    it 'belongs to a customer' do
      association = described_class.reflect_on_association(:customer)
      expect(association.macro).to eq :belongs_to
    end

    it 'belongs to an issuer' do
      association = described_class.reflect_on_association(:issuer)
      expect(association.macro).to eq :belongs_to
    end

    it 'belongs to a recipient' do
      association = described_class.reflect_on_association(:recipient)
      expect(association.macro).to eq :belongs_to
    end

    it 'has many product nfce_products' do
      association = described_class.reflect_on_association(:nfce_products)
      expect(association.macro).to eq :has_many
    end

  end








end
