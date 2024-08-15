
FactoryBot.define do
  factory :tax do
    valor_icms {10}
    valor_total_ipi {10}
    valor_total_cofins {10}
    valor_tributo {30}
    association :nfce
end
end
