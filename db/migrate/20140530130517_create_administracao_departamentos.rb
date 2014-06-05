class CreateAdministracaoDepartamentos < ActiveRecord::Migration
  def change
    create_table :departamentos do |t|
      t.string :nome
      t.string :descricao
      t.belongs_to :entidade, index: true
      t.belongs_to :responsavel, index: true

      t.timestamps
    end
  end
end
