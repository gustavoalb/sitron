# -*- encoding : utf-8 -*-
class AddMinutosToBancoDeHoras < ActiveRecord::Migration
  def change
    add_column :banco_de_horas, :minutos, :float
  end
end
