class RemoveUniqueConstraintFromNumeroNotaInNfces < ActiveRecord::Migration[7.1]
  def up
    execute <<-SQL
      DELETE FROM nfces a
      USING nfces b
      WHERE a.id < b.id
      AND a.numero_nota = b.numero_nota;
    SQL

    remove_index :nfces, :numero_nota if index_exists?(:nfces, :numero_nota)
    add_index :nfces, :numero_nota
  end

  def down
    remove_index :nfces, :numero_nota if index_exists?(:nfces, :numero_nota)
    add_index :nfces, :numero_nota, unique: true
  end
end
