# -*- encoding : utf-8 -*-
class CreateAdministracaoCargos < ActiveRecord::Migration
  def change
    create_table :cargos do |t|
      t.string :nome
      t.belongs_to :entidade, index: true

      t.timestamps
    end
  end
end
