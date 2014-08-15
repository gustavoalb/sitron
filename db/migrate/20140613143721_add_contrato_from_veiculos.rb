# -*- encoding : utf-8 -*-
class AddContratoFromVeiculos < ActiveRecord::Migration
  def change
    add_reference :veiculos, :contrato, index: true
    add_column :veiculos, :lote_id, :integer, index: true
  end
end
