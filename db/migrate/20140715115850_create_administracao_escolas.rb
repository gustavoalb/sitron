# -*- encoding : utf-8 -*-
class CreateAdministracaoEscolas < ActiveRecord::Migration
  def change
    create_table :escolas do |t|
      t.belongs_to :municipio, index: true
      t.integer :dependencia_administrativa
      t.integer :zona
      t.string :codigo
      t.string :nome
      t.string :telefone

      t.timestamps
    end
  end
end
