# -*- encoding : utf-8 -*-
class AddAgendaFromRequisicoes < ActiveRecord::Migration
  def change
    add_column :requisicoes, :agenda, :boolean,:default=>false
  end
end
