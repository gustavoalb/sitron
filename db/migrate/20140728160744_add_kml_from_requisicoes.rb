# -*- encoding : utf-8 -*-
class AddKmlFromRequisicoes < ActiveRecord::Migration
  def change
    add_column :requisicoes, :kml, :text
  end
end
