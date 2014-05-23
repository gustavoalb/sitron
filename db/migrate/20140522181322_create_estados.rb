# -*- encoding : utf-8 -*-
class CreateEstados < ActiveRecord::Migration
  def change
    create_table :estados do |t|
      t.string :sigla
      t.string :nome

      t.timestamps
    end
    add_index :estados, :sigla,                unique: true
  end
end
