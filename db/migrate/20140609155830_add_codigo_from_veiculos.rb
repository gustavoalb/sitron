# -*- encoding : utf-8 -*-
class AddCodigoFromVeiculos < ActiveRecord::Migration
  def change
    add_column :veiculos, :codigo, :string,index: true
  end
end
