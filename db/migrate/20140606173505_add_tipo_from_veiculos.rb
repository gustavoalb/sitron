# -*- encoding : utf-8 -*-
class AddTipoFromVeiculos < ActiveRecord::Migration
  def change
    add_reference :veiculos, :tipo, index: true
  end
end
