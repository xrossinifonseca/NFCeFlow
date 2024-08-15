FactoryBot.define do
  factory :nfce do

  serie {'A'}
  numero_nota {'0001'}
  data_emissao {'2024-08-14'}
  valor_total_desconto {0.0}
  valor_total_produtos {2500}
  valor_total {2700}
  association :customer
  association :recipient
  association :issuer

end
end
