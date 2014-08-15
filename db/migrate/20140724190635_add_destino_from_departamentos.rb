# -*- encoding : utf-8 -*-
class AddDestinoFromDepartamentos < ActiveRecord::Migration
  
  def change
    add_column :departamentos, :e_um_destino, :boolean,default: false
  end

end
