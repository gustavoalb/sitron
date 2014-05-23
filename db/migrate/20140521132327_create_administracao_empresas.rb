# -*- encoding : utf-8 -*-
class CreateAdministracaoEmpresas < ActiveRecord::Migration
  def change
    create_table :empresas do |t|
      t.string :nome
      t.string :cnpj
      t.integer :endereco_id
      t.integer :responsavel_id

      t.timestamps
    end
  end
end
