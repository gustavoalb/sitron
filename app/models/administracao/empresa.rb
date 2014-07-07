# -*- encoding : utf-8 -*-
class Administracao::Empresa < ActiveRecord::Base
	paginates_per 10	
	self.table_name =  "empresas"
	#attr_accessor :nome_responsavel

	has_one :endereco,:as=>:enderecavel
	belongs_to :responsavel,:class_name=>"Pessoa"
  has_many :departamentos,:foreign_key=>"entidade_id"
  has_one :rota, :as=>:roteavel
  

	validates_presence_of :nome,:cnpj#,:responsavel_id
	validates_uniqueness_of :cnpj
	

	after_create :adicionar_rota
  after_update :editar_rota



	accepts_nested_attributes_for :endereco, :reject_if => proc { |attributes| attributes['endereco'].blank? },:allow_destroy => true



	def endereco_completo
	  "#{self.endereco.logradouro}, #{self.endereco.numero}, #{self.endereco.bairro.nome if self.endereco.bairro}, #{self.endereco.cidade.nome} - #{self.endereco.estado.sigla}"
	end



  private

    def endereco_valid?
      self.endereco.present?
    end



	def adicionar_rota
		rota = self.create_rota(:latitude=>self.endereco.latitude,:longitude=>self.endereco.longitude,:destino=>"Rota para a Entidade #{self.nome}")
    end

    def editar_rota
		rota = self.rota 
		rota.latitude = self.endereco.latitude
		rota.longitude = self.endereco.longitude
		rota.save
    end


end
