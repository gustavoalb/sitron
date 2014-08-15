# -*- encoding : utf-8 -*-
class Administracao::Lote < ActiveRecord::Base
	validates_uniqueness_of :nome,:scope=>[:modalidade_id]
	has_many :veiculos,:dependent=>:destroy

	scope :do_tipo,lambda{|tipo| where(:tipo=>tipo.camelcase)}

	def lote_modalidade
     "M#{self.modalidade_id} - #{self.nome} - #{self.tipo}"
	end
end
