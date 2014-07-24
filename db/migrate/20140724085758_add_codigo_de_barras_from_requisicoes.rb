class AddCodigoDeBarrasFromRequisicoes < ActiveRecord::Migration
  def change
    add_column :requisicoes, :codigo_de_barras, :string
    add_column :requisicoes, :codigo, :string
    add_column :requisicoes, :numero_da_portaria,:string
  end
end
