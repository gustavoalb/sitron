class AddEnderecoFromEnderecos < ActiveRecord::Migration
  def change
    add_column :enderecos, :endereco, :string
  end
end
