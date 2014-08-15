# -*- encoding : utf-8 -*-
class AddSiglaFromDepartamentos < ActiveRecord::Migration
  def change
    add_column :departamentos, :sigla, :string
  end
end
