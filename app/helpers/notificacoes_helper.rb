module NotificacoesHelper

	def tipo_notificacao(n)
		icon = ''
		case n.tipo 
		when 0 
			icon+="<i class='fa fa-ban'></i>"
		when 1
			icon+="<i class='fa fa-exclamation-triangle'></i>"
		when 2
			icon+="<i class='fa fa-thumbs-o-down'></i>"
		when 3
			icon+="<i class='fa fa-male'></i>"
		when 4
			icon+="<i class='fa fa-car'></i>"
		when 5
			icon+="<i class='fa fa-bank'></i>"
		when 6
			icon+="<i class='fa fa-bug'></i>"
		else
			icon+="<i class='fa fa-cog'></i>"
		end
		retur raw(icons)
	end

	def link_notificacoes
		 if current_page?(gerencia_controle_requisicoes_index_path)
		 	link = "#"
		 else
		 	link = gerencia_controle_requisicoes_index_path
		 end
	end

end
