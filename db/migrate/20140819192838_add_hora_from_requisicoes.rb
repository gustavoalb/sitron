class AddHoraFromRequisicoes < ActiveRecord::Migration
  def change
    add_column :requisicoes, :hora, :integer
  end
end
