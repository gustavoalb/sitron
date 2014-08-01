class AddMotoFromDepartamentos < ActiveRecord::Migration
  def change
    add_column :departamentos, :usa_moto, :boolean,default: false
  end
end
