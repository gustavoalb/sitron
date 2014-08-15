# -*- encoding : utf-8 -*-
class AddHorasFromBancoDeHoras < ActiveRecord::Migration
  def change
    add_column :banco_de_horas, :horas_normais, :float,:default=>0.0
    add_column :banco_de_horas, :horas_extras, :float,:default=>0.0
  end
end
