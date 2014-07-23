class AddTurnoFromPosto < ActiveRecord::Migration
  def change
    add_column :postos, :turno, :integer
  end
end
