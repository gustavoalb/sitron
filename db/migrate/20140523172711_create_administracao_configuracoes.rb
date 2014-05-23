class CreateAdministracaoConfiguracoes < ActiveRecord::Migration
  def change
    create_table :configuracoes do |t|
      t.string :skin
      t.belongs_to :user

      t.timestamps
    end
  end
end
