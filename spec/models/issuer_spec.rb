require 'rails_helper'

RSpec.describe Issuer, type: :model do


  it 'is a valid issuer' do
    issuer = build(:issuer)
    expect(issuer).to be_valid
  end

  describe "validations" do

    it "is not valid if cnpj has already taken" do

      issuer = Issuer.create(
               cnpj: '12345678000195',
               nome: 'Empresa Exemplo LTDA',
               nome_fantasia: 'Exemplo',
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

      issuer_2 = build(:issuer,cnpj:"12345678000195")


      expect(issuer_2).not_to be_valid
      expect(issuer_2.errors[:cnpj]).to include("has already been taken")

    end


    it "is not valid if cnpj is not present" do
      issuer_2 = build(:issuer,cnpj:nil)
      expect(issuer_2).not_to be_valid
      expect(issuer_2.errors[:cnpj]).to include("can't be blank")

    end




    end





end
