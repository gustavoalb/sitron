class ChangeDataTypeForRequisicoesIda < ActiveRecord::Migration
  def change
  	change_table :requisicoes do |t|
      t.change :inicio,'timestamp with time zone'
      t.change :fim,'timestamp with time zone'
    end
  end
end
