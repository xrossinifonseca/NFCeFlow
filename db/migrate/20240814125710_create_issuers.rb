class CreateIssuers < ActiveRecord::Migration[7.1]
  def change
    create_table :issuers do |t|
      t.string :cnpj, limit: 14, null: false
      t.string :nome, null: false
      t.string :nome_fantasia, null: false
      t.string :logradouro
      t.string :numero, limit: 10
      t.string :municipio
      t.integer :codigo_municipio
      t.string :bairro
      t.string :pais
      t.string :uf, limit: 2
      t.string :cep, limit: 8
      t.string :telefone

      t.timestamps
    end
    add_index :issuers, :cnpj, unique: true

  end
end
