class AddMotivoFromRequisicoes < ActiveRecord::Migration
  def change
    add_column :requisicoes, :motivo_cancelamento, :string
  end
end
