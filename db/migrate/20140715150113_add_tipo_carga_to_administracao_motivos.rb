class AddTipoCargaToAdministracaoMotivos < ActiveRecord::Migration
  def change
    add_column :motivos, :tipo_carga, :integer
  end
end
