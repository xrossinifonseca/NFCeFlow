class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products do |t|
      t.string :nome, null: false
      t.string :ncm
      t.string :cfop
      t.timestamps
    end
  end
end
