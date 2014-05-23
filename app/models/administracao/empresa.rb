# -*- encoding : utf-8 -*-
class Administracao::Empresa < ActiveRecord::Base
	 paginates_per 1
	self.table_name =  "empresas"

	has_one :endereco,:as=>:enderecavel

	validates_presence_of :nome,:cnpj
	validates_uniqueness_of :cnpj
	
	accepts_nested_attributes_for :endereco, :reject_if => proc { |attributes| attributes['logradouro'].blank? },:allow_destroy => true
end
