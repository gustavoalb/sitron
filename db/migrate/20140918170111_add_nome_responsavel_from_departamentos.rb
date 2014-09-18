class AddNomeResponsavelFromDepartamentos < ActiveRecord::Migration
  def change
    add_column :departamentos, :nome_responsavel, :string
  end
end
