# -*- encoding : utf-8 -*-
class CreateAdministracaoVeiculos < ActiveRecord::Migration
  def change
    create_table :veiculos do |t|
      t.integer :tipo
      t.string  :placa, index: true
      t.string :motor
      t.integer :direcao
      t.integer :marca
      t.string :modelo
      t.integer :capacidade_carga,default: 0
      t.integer :capacidade_passageiros,default: 4
      t.integer :ano_fabricacao
      t.integer :ano_modelo
      t.boolean :intens_obrigatorios,default: false
      t.text :observacao
      t.string :qrcode
      t.string :codigo_de_barras
      t.string :gps_ip
      t.string :gps_imei
      t.belongs_to :modalidade, index: true
      t.belongs_to :combustivel, index: true
      t.belongs_to :turno, index: true
      t.belongs_to :empresa,index: true

      t.timestamps
    end
  end
end
