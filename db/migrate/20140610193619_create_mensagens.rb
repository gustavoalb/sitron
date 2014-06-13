class CreateMensagens < ActiveRecord::Migration
  def change
    create_table :mensagens do |t|
      t.string :texto
      t.belongs_to :remetente, index: true
      t.belongs_to :destinatario, index: true
      t.string :tipo_usuario
      t.boolean :lido,default: false
      t.integer :objeto_id
      t.string :objeto_type
      t.string :state

      t.timestamps
    end
  end
end
