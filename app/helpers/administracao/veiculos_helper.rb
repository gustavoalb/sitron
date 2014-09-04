# -*- encoding : utf-8 -*-
module Administracao::VeiculosHelper

	def posto_veiculo(v)
		html = ""
		if v.esta_no_patio? and v.pode_sair_do_patio?
			html += link_to link_icone("Remover do Pátio",'car'), administracao_veiculo_remover_posto_path(v),:method=>:post,:class=>"btn btn-orange btn-xs", data: {:confirm=>"Deseja realmente remover o Veículo do Pátio?"}
		elsif v.esta_no_patio? and !v.pode_sair_do_patio?
			html += "<span class='badge badge-primary'>Não pode ser removido no momento</span>"
		elsif !v.esta_no_patio?
            html = "<span class='badge badge-info'>Não está no Pátio</span>"
		end
		return raw(html)
	end
end
