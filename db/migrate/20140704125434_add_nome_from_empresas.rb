class AddNomeFromEmpresas < ActiveRecord::Migration
  def change
    add_column :empresas, :nome_responsavel, :string
  end
end
