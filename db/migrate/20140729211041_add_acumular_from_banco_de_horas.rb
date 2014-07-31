class AddAcumularFromBancoDeHoras < ActiveRecord::Migration
  def change
    add_column :banco_de_horas, :acumulo_horas_extras, :float
  end
end
