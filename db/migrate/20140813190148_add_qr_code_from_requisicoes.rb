# -*- encoding : utf-8 -*-
class AddQrCodeFromRequisicoes < ActiveRecord::Migration
  def change
    add_column :requisicoes, :qrcode, :string
  end
end
