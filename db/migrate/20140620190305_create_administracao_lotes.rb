class CreateAdministracaoLotes < ActiveRecord::Migration
  def change
    create_table :lotes do |t|
      t.string :nome
      t.integer :numero_postos
      t.string  :tipo
      t.string :cor
      t.belongs_to :modalidade,index: true

      t.timestamps
    end
  end
end
