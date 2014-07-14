class AddTipoFromRequisicoes < ActiveRecord::Migration
  def change
    add_column :requisicoes, :tipo_requisicao, :integer
    add_column :requisicoes, :numero_passageiros,:integer,:default=>1
  end
end
