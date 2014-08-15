# -*- encoding : utf-8 -*-
class AddStateFromVeiculos < ActiveRecord::Migration
  def change
    add_column :veiculos, :state, :string
  end
end
