# -*- encoding : utf-8 -*-
class RemoveHorasFromBancoDeHoras < ActiveRecord::Migration
  def change
    remove_column :banco_de_horas, :horas_normais, :integer
    remove_column :banco_de_horas, :horas_extras, :integer
  end
end
