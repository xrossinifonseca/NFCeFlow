FactoryBot.define do
  factory :issuer do
    cnpj { '12345678000195' }
    nome { 'Empresa Exemplo LTDA' }
    nome_fantasia {'Exemplo'}
    logradouro {"Rua Exemplo"}
    numero {'123'}
    municipio {'Cidade Exemplo'}
    codigo_municipio {1234567}
    bairro {'Bairro Exemplo'}
    pais {'Brasil'}
    uf {'SP'}
    cep {'12345678'}
    telefone {"123456790"}
end
end
