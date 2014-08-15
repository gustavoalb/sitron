# -*- encoding : utf-8 -*-
class Motivo < ActiveRecord::Migration
  def change
  	 add_column :motivos, :urgente, :boolean,:default=>false
  end
end
