class CreateAdministracaoPatios < ActiveRecord::Migration
  def change
    create_table   :patios do |t|
      t.datetime   :data_entrada
      t.belongs_to :veiculo, index: true
      t.belongs_to :motorista, index: true
      t.belongs_to :empresa,index: true
      t.datetime   :data_saida
      t.string     :state

      t.integer    :position

      t.timestamps
    end
  end
end
