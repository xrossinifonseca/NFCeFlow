FactoryBot.define do

  factory :recipient do
    cnpj {'12345678000195'}
    nome {'Empresa Exemplo LTDA'}
    logradouro {'Rua Exemplo'}
    numero {'123'}
    municipio {'Cidade Exemplo'}
    codigo_municipio {1234567}
    bairro {'Bairro Exemplo'}
    pais {'Brasil'}
    uf {'SP'}
    cep {'12345678'}
    telefone {'1122334455'}

  end


end
