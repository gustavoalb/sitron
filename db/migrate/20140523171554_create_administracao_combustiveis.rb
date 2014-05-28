# -*- encoding : utf-8 -*-
class CreateAdministracaoCombustiveis < ActiveRecord::Migration
  def change
    create_table :combustiveis do |t|
      t.string :nome
      t.money :valor,amount: { null: true, default: nil }

      t.timestamps
    end
  end
end
