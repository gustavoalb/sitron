# -*- encoding : utf-8 -*-
require 'test_helper'



class Administracao::EmpresaTest < ActiveSupport::TestCase

  # test "the truth" do
  #   assert true
  # end

  test 'se empresa o nome da empresa é válido' do

  	empresa = Administracao::Empresa.new

  	assert !empresa.valid?, "Falta nome da Empresa"
  	empresa.nome = "Empresa 1"
  	assert !empresa.valid?, "Falta CNPJ da Empresa"
  	empresa.cnpj  = "0098977876623"
  	assert empresa.valid?
  end

test 'se o cnpj é único' do 
	empresa = Administracao::Empresa.new(:nome=>"Empresa",:cnpj => "00394577000125")
	assert !empresa.save,"Erro ao Salvar a Empresa"
	assert_equal "Cpnj não pode ser Duplicado", empresa.errors[:cnpj].join(', ')

end


  

end
