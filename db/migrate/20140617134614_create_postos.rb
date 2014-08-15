# -*- encoding : utf-8 -*-
class CreatePostos < ActiveRecord::Migration
  def change
    create_table :postos do |t|
      t.datetime   :entrada
      t.belongs_to :patio
      t.belongs_to :veiculo, index: true
      t.belongs_to :contrato,index: true
      t.belongs_to :empresa,index: true
      t.belongs_to :modalidade,index: true
      t.belongs_to :servico,index: true
      t.belongs_to    :lote,index:true
      t.datetime   :saida
      t.string     :state
      t.integer    :position
      t.boolean    :rotativo,:default=>false
      t.string     :codigo
      t.string     :codigo_substituto

      t.timestamps
    end
  end
end
