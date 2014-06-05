class CreateRequisicoes < ActiveRecord::Migration
  def change
    create_table :requisicoes do |t|
      t.string :numero
      t.string :motivo
      t.string :descricao
      t.belongs_to :requisitante, index: true
      t.date :data_ida
      t.time :hora_ida
      t.date :data_volta
      t.time :hora_volta
      t.string :periodo
      t.boolean :periodo_longo
      t.datetime :inicio
      t.datetime :fim
      t.belongs_to :posto, index: true
      t.belongs_to :preferencia, index: true
      t.string     :state
      t.float  :distancia

      t.timestamps
    end
  end
end
