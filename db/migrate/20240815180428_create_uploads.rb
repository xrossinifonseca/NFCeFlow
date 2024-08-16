class CreateUploads < ActiveRecord::Migration[7.1]
  def change
    create_table :uploads do |t|
      t.string :file_name
      t.string :status
      t.text :error_message
      t.references :customer, null: false, foreign_key: true

      t.timestamps
    end
  end
end
