class AddTipoCargaToRequisicoes < ActiveRecord::Migration
  def change
    add_column :requisicoes, :tipo_carga, :integer
  end
end
