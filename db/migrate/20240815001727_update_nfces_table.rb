class UpdateNfcesTable < ActiveRecord::Migration[7.1]
  def change

    change_table :nfces do |t|
      t.decimal :valor_total_desconto, precision: 10, scale: 2
      t.decimal :valor_total_produtos, precision: 10, scale: 2
      t.decimal :valor_total, precision: 10, scale: 2

      t.remove :customer_id, :issuer_id, :recipient_id

      t.integer :customer_id, null: true
      t.integer :issuer_id, null: true
      t.integer :recipient_id, null: true
    end

  end
end
