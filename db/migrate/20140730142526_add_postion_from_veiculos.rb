class AddPostionFromVeiculos < ActiveRecord::Migration
  def change
    add_column :veiculos, :position, :integer
  end
end
