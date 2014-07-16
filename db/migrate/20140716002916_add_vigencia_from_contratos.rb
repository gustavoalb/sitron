class AddVigenciaFromContratos < ActiveRecord::Migration
  def change
    add_column :contratos, :inicio_vigencia, :date
    add_column :contratos, :fim_vigencia, :date
  end
end
