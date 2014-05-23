class CreateAdministracaoCombustiveis < ActiveRecord::Migration
  def change
    create_table :combustiveis do |t|
      t.string :nome
      t.decimal :valor, :precision => 18, :scale => 2, :default => 0.0

      t.timestamps
    end
  end
end
