# -*- encoding : utf-8 -*-
class AddDescricaoFromEnderecos < ActiveRecord::Migration
  def change
    add_column :enderecos, :descricao, :string
  end
end
