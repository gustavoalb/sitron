class CreateRequisicoesTipos < ActiveRecord::Migration
  def change
    create_table :requisicoes_tipos do |t|
      t.references :tipo, index: true
      t.references :requisicao, index: true
    end
  end
end
