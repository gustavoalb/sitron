# -*- encoding : utf-8 -*-
class AddDataFromPostos < ActiveRecord::Migration
  def change
    add_column :postos, :data_entrada, :date
  end
end
