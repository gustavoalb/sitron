class CreateAdministracaoRotas < ActiveRecord::Migration
  def change
    create_table :rotas do |t|
      t.string :destino
      t.string :roteavel_type
      t.belongs_to :roteavel, index: true
      t.string :tempo_previsto
      t.float :latitude
      t.float :longitude
      t.boolean :rota_longa
      t.boolean :intermunicipal

      t.timestamps
    end
  end
end
