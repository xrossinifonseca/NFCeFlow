class RestoreNfcesTableRelationships < ActiveRecord::Migration[7.1]
  def change
    change_table :nfces do |t|
      unless column_exists?(:nfces, :customer_id)
        t.integer :customer_id, null: false
      end

      unless column_exists?(:nfces, :issuer_id)
        t.integer :issuer_id, null: false
      end

      unless column_exists?(:nfces, :recipient_id)
        t.integer :recipient_id, null: false
      end

      add_foreign_key :nfces, :customers, column: :customer_id
      add_foreign_key :nfces, :issuers, column: :issuer_id
      add_foreign_key :nfces, :recipients, column: :recipient_id
    end
  end
end
