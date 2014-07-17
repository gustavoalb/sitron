module MensagensHelper

	def remetente(m)
		if m.remetente
			return m.remetente.pessoa.nome
		else
			return "Sitron/SEED"
		end
	end

	def m_lida(m)
      if m.lida?
      	return link_icone("","envelope-o")
      else
      	return link_icone("","envelope")
      	end 
	end
end
