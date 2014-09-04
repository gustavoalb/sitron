class CreateAdministracaoRelatoriosDiarios < ActiveRecord::Migration
  def change
    create_table :relatorios_diarios do |t|
      t.integer :tipo
      t.string :descricao
      t.column :data,'timestamp with time zone'
      t.belongs_to :user, index: true

      t.timestamps
    end
  end
end
