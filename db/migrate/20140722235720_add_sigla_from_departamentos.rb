class AddSiglaFromDepartamentos < ActiveRecord::Migration
  def change
    add_column :departamentos, :sigla, :string
  end
end
