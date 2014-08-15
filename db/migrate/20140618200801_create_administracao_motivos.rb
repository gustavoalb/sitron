# -*- encoding : utf-8 -*-
class CreateAdministracaoMotivos < ActiveRecord::Migration
  def change
    create_table :motivos do |t|
      t.string :nome
      t.belongs_to :tipo, index: true
      t.boolean :carga,default: false
      t.boolean :passageiro,default: false
      t.boolean :entrega_documento,default: false
      t.boolean :interior,default: false
      t.boolean :viagem_longa,default: false
      t.belongs_to :lote,index: true
      t.timestamps
    end
  end
end
