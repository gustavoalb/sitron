class CreateAvaliacoes < ActiveRecord::Migration
  def change
    create_table :avaliacoes do |t|
      t.belongs_to :requisicao, index: true
      t.text :texto
      t.integer :tipo
      t.belongs_to :avaliador, index: true

      t.timestamps
    end
  end
end
