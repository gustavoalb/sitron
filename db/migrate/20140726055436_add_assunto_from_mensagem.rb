# -*- encoding : utf-8 -*-
class AddAssuntoFromMensagem < ActiveRecord::Migration
  def change
    add_column :mensagens, :assunto, :string
  end
end
