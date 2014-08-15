# -*- encoding : utf-8 -*-
class AddDepartamentoFromPessoas < ActiveRecord::Migration
  def change
    add_reference :pessoas, :departamento, index: true
  end
end
