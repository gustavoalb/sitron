# -*- encoding : utf-8 -*-
class AddNomeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :nome, :string
    add_column :users,:cpf, :string
    add_column :users, :authentication_token, :string
  end
end
