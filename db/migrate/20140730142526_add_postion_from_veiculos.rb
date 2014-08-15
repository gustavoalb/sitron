# -*- encoding : utf-8 -*-
class AddPostionFromVeiculos < ActiveRecord::Migration
  def change
    add_column :veiculos, :position, :integer
  end
end
