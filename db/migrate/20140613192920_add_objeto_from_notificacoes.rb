# -*- encoding : utf-8 -*-
class AddObjetoFromNotificacoes < ActiveRecord::Migration
  def change
    add_column :notificacoes, :objeto_type, :string
    add_reference :notificacoes, :objeto, index: true
  end
end
