class AddEspecialFromPostos < ActiveRecord::Migration
  def change
    add_column :postos, :especial, :boolean,default: false
  end
end
