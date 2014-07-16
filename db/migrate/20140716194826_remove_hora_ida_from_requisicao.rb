class RemoveHoraIdaFromRequisicao < ActiveRecord::Migration
  def change
    remove_column :requisicoes, :hora_ida, :time
    remove_column :requisicoes, :hora_volta, :time
  end
end
