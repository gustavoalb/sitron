class AddDepartamentoFromPessoas < ActiveRecord::Migration
  def change
    add_reference :pessoas, :departamento, index: true
  end
end
