# -*- encoding : utf-8 -*-
class CreateBairros < ActiveRecord::Migration
  def change
    create_table :bairros do |t|
      t.string :nome
      t.integer :cidade_id
      t.integer :estado_id

      t.timestamps
    end
      add_index :bairros, :nome,                unique: false
  end
end
