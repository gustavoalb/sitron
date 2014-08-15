# -*- encoding : utf-8 -*-
class AddHoraIdaFromRequisicao < ActiveRecord::Migration
  def change
    add_column :requisicoes, :hora_ida, 'time with time zone'
    add_column :requisicoes, :hora_volta, 'time with time zone'
  end
end
