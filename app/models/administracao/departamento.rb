class Administracao::Departamento < ActiveRecord::Base
  belongs_to :entidade,:class_name=>"Empresa"
  belongs_to :responsavel,:class_name=>"Pessoa"
  has_one :endereco,:as=>:enderecavel
  attr_accessor :nome_responsavel,:cidade_nome,:bairro_nome

	accepts_nested_attributes_for :endereco, :reject_if => proc { |attributes| attributes['logradouro'].blank? },:allow_destroy => true
end
