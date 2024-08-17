class UpdateNfceProductsTable < ActiveRecord::Migration[7.1]
  def change
    change_table :nfce_products do |t|
      t.decimal :valor_total, precision: 10, scale: 2

      t.remove :quantidade

      t.change :unidade_comercializada, :string
      t.change :quantidade_comercializada, :decimal, precision: 10, scale: 2
      t.change :valor_unitario, :decimal, precision: 10, scale: 2
      t.change :valor_icms, :decimal, precision: 10, scale: 2
      t.change :valor_ipi, :decimal, precision: 10, scale: 2

      t.change :product_id, :integer
      t.change :nfce_id, :integer

    end
  end
end
