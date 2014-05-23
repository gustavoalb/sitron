# -*- encoding : utf-8 -*-
class CreateEnderecos < ActiveRecord::Migration
  def change
    create_table :enderecos do |t|
      t.string :logradouro
      t.string :numero
      t.string :complemento
      t.string :cep
      t.integer :bairro_id
      t.integer :cidade_id
      t.integer :estado_id
      t.float :latitude
      t.float :longitude
      t.integer :enderecavel_id
      t.string :enderecavel_type

      t.timestamps
    end

    add_index :enderecos, :logradouro,                unique: false
    add_index :enderecos, :numero, unique: false
    add_index :enderecos, :latitude, unique: false
    add_index :enderecos, :longitude, unique: false
     
  end
end
