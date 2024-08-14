class CreateNfces < ActiveRecord::Migration[7.1]
  def change
    create_table :nfces do |t|
      t.string :serie, null: false
      t.string :numero_nota, null: false
      t.date :data_emissao, null: false
      t.references :customer, null: false, foreign_key: true
      t.references :issuer, null: false, foreign_key: true
      t.references :recipient, null: false, foreign_key: true

      t.timestamps
    end


    add_index :nfces, :numero_nota, unique: true

  end
end
