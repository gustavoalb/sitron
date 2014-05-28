# -*- encoding : utf-8 -*-
class CreateAdministracaoModalidades < ActiveRecord::Migration
  def change
    create_table :modalidades do |t|
      t.string :nome
      t.integer :periodo_diario,default: 8
      t.integer :dias_mes,default: 22
      t.boolean :com_motorista, default: false
      t.boolean :com_combustivel,default: false
      t.boolean :quilometragem_livre,default: false
      t.boolean :mes_completo,default: false

      t.timestamps
    end
    
  end
end
