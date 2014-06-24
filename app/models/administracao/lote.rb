class Administracao::Lote < ActiveRecord::Base
	validates_uniqueness_of :nome,:scope=>[:modalidade_id]

	def lote_modalidade
     "M#{self.modalidade_id} - #{self.nome} - #{self.tipo}"
	end
end
