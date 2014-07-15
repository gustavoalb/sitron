class AddTipoFromMotivos < ActiveRecord::Migration
  def change
    add_column :motivos, :tipo_requisicao, :integer
  end
end
