# -*- encoding : utf-8 -*-
class AddTipoCargaToRequisicoes < ActiveRecord::Migration
  def change
    add_column :requisicoes, :tipo_carga, :integer
  end
end
