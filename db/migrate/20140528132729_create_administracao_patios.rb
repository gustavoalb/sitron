class CreateAdministracaoPatios < ActiveRecord::Migration
  def change
    create_table   :patios do |t|
      t.datetime   :data_entrada
      t.datetime   :data_saida
      t.string     :state

      t.integer    :position

      t.timestamps
    end
  end
end
