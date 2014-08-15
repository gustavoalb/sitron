class AddPositionFromRequisicoes < ActiveRecord::Migration
  def change
    add_column :requisicoes, :position, :integer
  end
end
