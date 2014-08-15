# -*- encoding : utf-8 -*-
class AddAvatarFromUsers < ActiveRecord::Migration
  def change
    add_column :users, :avatar, :string
  end
end
