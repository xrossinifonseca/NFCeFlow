class CreateTaxes < ActiveRecord::Migration[7.1]
  def change
    create_table :taxes do |t|
      t.references :nfce , null: false, foreign_key: true
      t.decimal :valor_pis
      t.decimal :valor_cofins
      t.timestamps
    end
  end
end
