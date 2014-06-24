# -*- encoding : utf-8 -*-
class Administracao::Modalidade < ActiveRecord::Base

    has_many :lotes
    
	def codigo_modalidade
		code =  self.id.to_s
		case code.chars.count
		when 1
			code_mod = "0000#{code}"
		when 2
			code_mod = "000#{code}"
		when 3
			code_mod = "00#{code}"
		when 4
			code_mod = "0#{code}"
		else
			code_mod = "#{code}"
		end
		return code_mod
	end


	def inf_modalidade 
		cb = ''
		mt = ''
		km = ''

		if self.com_combustivel
			cb = "com combustível"
		else
			cb = "sem combustível"
		end

		if self.com_motorista
			mt = "com motorista"
		else
			mt = "sem motorista"
		end

		if self.quilometragem_livre
			km = "quilometragem livre"
		end

		[self.nome,cb,mt, km].compact.join(', ') 
	end

	



end
