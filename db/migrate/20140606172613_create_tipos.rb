# -*- encoding : utf-8 -*-
class CreateTipos < ActiveRecord::Migration
  def change
    create_table :tipos do |t|
      t.string :nome

      t.timestamps
    end
  end
end
