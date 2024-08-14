class CreateNfceProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :nfce_products do |t|
      t.references :nfce, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.decimal :quantidade, null: false
      t.decimal :valor_unitario, null: false
      t.string :unidade_comercializada, null: false
      t.decimal :quantidade_comercializada, null: false
      t.decimal :valor_icms
      t.decimal :valor_ipi
      t.timestamps
    end
  end
end
