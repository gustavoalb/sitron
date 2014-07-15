class RemoveTipoCargaFromMotivos < ActiveRecord::Migration
  def change
    remove_column :motivos, :tipo_carga, :integer
  end
end
