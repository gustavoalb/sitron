class AddCodigosFromVeiculos < ActiveRecord::Migration
  def change
    add_column :veiculos, :codigo_de_barras_s, :string
    add_column :veiculos, :codigo_s, :string
  end
end
