class AddEspecialFromVeiculos < ActiveRecord::Migration
  def change
    add_column :veiculos, :especial, :boolean,default: false
  end
end
