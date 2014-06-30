class CreateRequisicoesPessoas < ActiveRecord::Migration
  def change
    create_table :pessoas_requisicoes do |t|
      t.references :pessoa, index: true
      t.references :requisicao, index: true
    end
  end
end
