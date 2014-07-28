class AddAssuntoFromMensagem < ActiveRecord::Migration
  def change
    add_column :mensagens, :assunto, :string
  end
end
