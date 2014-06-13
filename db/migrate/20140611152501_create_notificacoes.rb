class CreateNotificacoes < ActiveRecord::Migration
  def change
    create_table :notificacoes do |t|
      t.string :texto
      t.string :motivo
      t.string :state
      t.belongs_to :origem, index: true
      t.belongs_to :entidade, index: true
      t.belongs_to :posto, index: true
      t.integer :tipo

      t.timestamps
    end
  end
end
