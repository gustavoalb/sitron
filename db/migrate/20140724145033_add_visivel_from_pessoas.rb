class AddVisivelFromPessoas < ActiveRecord::Migration
  def change
    add_column :pessoas, :visivel, :boolean,default: true
  end
end
