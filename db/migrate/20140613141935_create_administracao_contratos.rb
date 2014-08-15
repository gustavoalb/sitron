# -*- encoding : utf-8 -*-
class CreateAdministracaoContratos < ActiveRecord::Migration
  def change
    create_table :contratos do |t|
      t.string :numero
      t.belongs_to :empresa, index: true
      t.string :lei
      t.string :artigo

      t.timestamps
    end
  end
end
