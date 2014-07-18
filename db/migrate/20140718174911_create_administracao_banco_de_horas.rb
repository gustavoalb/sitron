class CreateAdministracaoBancoDeHoras < ActiveRecord::Migration
  def change
    create_table :banco_de_horas do |t|
      t.belongs_to :posto, index: true
      t.belongs_to :veiculo, index: true
      t.integer :dia
      t.integer :mes
      t.integer :ano
      t.integer :horas_normais
      t.integer :horas_extras
      t.integer :numero_semana
      t.date :inicio_semana
      t.date :fim_semana

      t.timestamps
    end
  end
end
