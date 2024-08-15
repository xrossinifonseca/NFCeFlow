class UpdateTaxesTable < ActiveRecord::Migration[7.1]
  def change
    change_table :taxes do |t|
      t.decimal :valor_total_pis, precision: 10, scale: 2
      t.decimal :valor_total_cofins, precision: 10, scale: 2
      t.decimal :valor_icms, precision: 10, scale: 2
      t.decimal :valor_total_ipi, precision: 10, scale: 2
      t.decimal :valor_tributo, precision: 10, scale: 2

      t.remove :valor_pis
      t.remove :valor_cofins


    end
  end

end
