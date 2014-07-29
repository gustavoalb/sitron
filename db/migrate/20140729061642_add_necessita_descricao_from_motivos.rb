class AddNecessitaDescricaoFromMotivos < ActiveRecord::Migration
  def change
    add_column :motivos, :necessita_descricao, :boolean,:default=>false
  end
end
