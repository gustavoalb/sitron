# -*- encoding : utf-8 -*-
class CreateCidades < ActiveRecord::Migration
  def change
    create_table :cidades do |t|
      t.string :nome
      t.integer :estado_id
      t.boolean :capital,default: false

      t.timestamps
    end
    add_index :cidades, :nome,                unique: false
  end
end
