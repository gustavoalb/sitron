# -*- encoding : utf-8 -*-
class AddUserFromNotificacoes < ActiveRecord::Migration
  def change
    add_reference :notificacoes, :user, index: true
  end
end
