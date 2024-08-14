require 'rails_helper'

RSpec.describe Recipient, type: :model do

  it 'is a valid recipient' do
    recipient = build(:recipient)
    expect(recipient).to be_valid
  end


  describe "validations" do

    it "is not valid if cnpj has already taken" do

      recipient = Recipient.create(
               cnpj: '12345678000195',
               nome: 'Empresa Exemplo LTDA',
               logradouro: 'Rua Exemplo',
               numero: '123',
               municipio: 'Cidade Exemplo',
                codigo_municipio: 1234567,
                bairro: 'Bairro Exemplo',
                pais: 'Brasil',
                uf: 'SP',
                cep: '12345678',
                 telefone: '1122334455',
      )

      recipient_2 = build(:recipient,cnpj:"12345678000195")


      expect(recipient_2).not_to be_valid
      expect(recipient_2.errors[:cnpj]).to include("has already been taken")

    end


    it "is not valid if cnpj is not present" do
      recipient_2 = build(:recipient,cnpj:nil)
      expect(recipient_2).not_to be_valid
      expect(recipient_2.errors[:cnpj]).to include("can't be blank")
    end

    end





end
