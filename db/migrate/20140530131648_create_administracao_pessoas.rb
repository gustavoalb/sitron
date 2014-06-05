class CreateAdministracaoPessoas < ActiveRecord::Migration
  def change
    create_table :pessoas do |t|
      t.string :nome
      t.string :cpf
      t.string :email
      t.string :matricula
      t.belongs_to :cargo, index: true
      t.belongs_to :entidade,index: true
      t.belongs_to :user,index: true

      t.timestamps
    end
  end
end
