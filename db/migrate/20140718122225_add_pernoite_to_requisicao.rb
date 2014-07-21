class AddPernoiteToRequisicao < ActiveRecord::Migration
  def change
    add_column :requisicoes, :pernoite, :boolean
  end
end
