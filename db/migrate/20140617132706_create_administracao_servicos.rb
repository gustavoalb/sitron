class CreateAdministracaoServicos < ActiveRecord::Migration
  def change
    create_table :servicos do |t|
      t.belongs_to :requisicao, index: true
      t.belongs_to :veiculo, index: true
      t.belongs_to :user, index: true
      t.belongs_to :empresa,index: true
      t.belongs_to :contrato, index: true
      t.integer    :lote, index: true
      t.datetime :saida
      t.datetime :chegada
      t.float :gasto_combustivel
      t.money :valor_combustivel,amount: { null: true, default: nil }
      t.float :distancia
      t.boolean :atendido,:default=>true
      t.boolean :problema,:default=>false
      t.boolean :imediato,:default=>false

      t.timestamps
    end
  end
end
