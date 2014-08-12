class AddMotoristaFromVeiculos < ActiveRecord::Migration
  def change
    add_column :veiculos, :motorista, :string
  end
end
