class AddUsaEspecialFromDepartamentos < ActiveRecord::Migration
  def change
    add_column :departamentos, :usa_especial, :boolean,:default=>false
  end
end
