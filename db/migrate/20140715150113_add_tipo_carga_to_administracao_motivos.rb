# -*- encoding : utf-8 -*-
class AddTipoCargaToAdministracaoMotivos < ActiveRecord::Migration
  def change
    add_column :motivos, :tipo_carga, :integer
  end
end
