# -*- encoding : utf-8 -*-
class RemoveNumeroPassageirosFromRequisicoes < ActiveRecord::Migration
  def change
    remove_column :requisicoes, :numero_passageiros, :integer
    add_column :requisicoes, :numero_passageiros,:integer
  end
end
