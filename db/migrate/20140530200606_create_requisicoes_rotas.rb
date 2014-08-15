# -*- encoding : utf-8 -*-
class CreateRequisicoesRotas < ActiveRecord::Migration
  def change
    create_table :requisicoes_rotas do |t|
    	t.references :rota,index: true
        t.references :requisicao,index: true
    end
  end
end
