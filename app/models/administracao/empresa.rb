# -*- encoding : utf-8 -*-
class Administracao::Empresa < ActiveRecord::Base
	 paginates_per 10
	self.table_name =  "empresas"
	attr_accessor :nome_responsavel

	has_one :endereco,:as=>:enderecavel
	belongs_to :responsavel,:class_name=>"Pessoa"
    has_many :departamentos,:foreign_key=>"entidade_id"

	validates_presence_of :nome,:cnpj
	validates_uniqueness_of :cnpj
	
	accepts_nested_attributes_for :endereco, :reject_if => proc { |attributes| attributes['logradouro'].blank? },:allow_destroy => true
	
	def endereco_completo
	  "#{self.endereco.logradouro}, #{self.endereco.numero}, #{self.endereco.bairro.nome if self.endereco.bairro}, #{self.endereco.cidade.nome} - #{self.endereco.estado.sigla}"
	end
end
