class CreateAdministracaoProvisoes < ActiveRecord::Migration
  def change
    create_table :provisoes do |t|
      t.belongs_to :veiculo, index: true
      t.belongs_to :requisicao, index: true
      t.boolean :ativo,default: true
      t.datetime :data_aprovisionamento

      t.timestamps
    end
  end
end
