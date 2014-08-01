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

	def link_page(link_atual,titulo,icone)
		link = ''
		if current_page?(link_atual)
			link = "#"
		else
			link = link_to link_icone(titulo,icone),link_atual,:class=>'active'
		end

		return link
	end






	def v_notificacao(notificacoes)
		

		html=""

		html+="<li class='dropdown'>"
		html+="<a href='#' class='hasnotifications dropdown-toggle' data-toggle='dropdown' id='notificacoes'><i class='fa fa-bell'></i>"
		html+="<div id='contador_notificacao'>"
		if notificacoes.count > 0
			html+="<span class='badge'>#{notificacoes.count}</span>"
		end
		html+="</div>"
		html+="</a>"
		html+="<ul class='dropdown-menu notifications arrow'>"
		html+="<li class='dd-header'>"
		html+="<div id='header_notificacoes'>"
        if notificacoes.count > 0
		html+="<span>Você tem #{notificacoes.count} #{'nova'.pluralize(notificacoes.count)} #{'notificação'.pluralize(notificacoes.count)}</span>"
		html+="<span>#{link_to 'Marcar como visto',marcar_vista_notificacoes_url,:method=>:post,:remote=>true}</span>"
		else
		html+='<span>Nenhuma nova Notificação</span>'
	end
		html+="</div>"
		html+="</li>"
		html+="<div tabindex='5003' style='overflow-y: hidden;' class='scrollthis'>"
		html+="<div id='lista_notificacoes'>"
		notificacoes.each do |notificacao|	
			case notificacao.tipo
			when "aviso"
				tipo = "notification-order"
				icone = "fa fa-bolt"
			when "cancelamento"
				tipo = "notification-danger"
				icone = "fa fa-thumbs-down"
			when "confirmacao"
				tipo = "notification-success"
				icone = "fa fa-car"
			when "problema"
				tipo = "notification-failure"
				icone = "fa fa-times-circle"
			end
			
			if notificacao.objeto_type == "Requisicao" and notificacao.tipo == "aviso"
				url = "#{gerencia_controle_requisicoes_detalhes_requisicao_url(:requisicao_id=>notificacao.objeto.id,:notificacao_id=>notificacao.id)}" 
			elsif notificacao.objeto_type == "Requisicao" and notificacao.tipo == "cancelamento" and current_user.id == notificacao.user_id
				url = "#{requisicao_path(notificacao.objeto_id,:notificacao=>notificacao.id)}"
			elsif notificacao.objeto_type == "Requisicao" and notificacao.tipo == "confirmacao" and current_user.id == notificacao.user_id
				url = "#{requisicao_path(notificacao.objeto_id,:notificacao=>notificacao.id)}"
			end

			html+="<li><a href='#{url}' class='#{tipo}'>"
			html+="<span class='hora'>#{tempo_relativo(notificacao.created_at)}</span>"
			html+="<i class='#{icone}'></i>"
			html+="<span class='msg'>#{notificacao.texto}</span></a></li>"
		end

		html+="</div></div>"
		html+="<li class='dd-footer'>#{link_page(gerencia_controle_requisicoes_index_path,'Todas as Requisições Urgentes','bolt')}</li>"
		html+="</ul>"
		html+="</li>"

		return raw(html)
	end


	def listar_notificacoes(notificacoes)
		html=""
		notificacoes.each do |notificacao|	
			case notificacao.tipo
			when "aviso"
				tipo = "notification-order"
				icone = "fa fa-bolt"
			when "cancelamento"
				tipo = "notification-danger"
				icone = "fa fa-thumbs-down"
			when "confirmacao"
				tipo = "notification-success"
				icone = "fa fa-car"
			when "problema"
				tipo = "notification-failure"
				icone = "fa fa-times-circle"
			end
			
			
			if notificacao.objeto_type == "Requisicao" and notificacao.tipo == "aviso"
				url = "#{gerencia_controle_requisicoes_detalhes_requisicao_url(:requisicao_id=>notificacao.objeto.id,:notificacao_id=>notificacao.id)}" 
			elsif notificacao.objeto_type == "Requisicao" and notificacao.tipo == "cancelamento" and current_user.id == notificacao.user_id
				url = "#{requisicao_path(notificacao.objeto_id,:notificacao=>notificacao.id)}"
			elsif notificacao.objeto_type == "Requisicao" and notificacao.tipo == "confirmacao" and current_user.id == notificacao.user_id
				url = "#{requisicao_path(notificacao.objeto_id,:notificacao=>notificacao.id)}"
			end

			html+="<li><a href='#{url}' class='#{tipo}'>"
			html+="<span class='hora'>#{tempo_relativo(notificacao.created_at)}</span>"
			html+="<i class='#{icone}'></i>"
			html+="<span class='msg'>#{notificacao.texto}</span></a></li>"
		end
		return raw(html)
	end



	def listar_notificacoes_alt(notificacoes)
		html=""
		notificacoes.each do |notificacao|	
			case notificacao.tipo
			when "aviso"
				tipo = "notification-order"
				icone = "fa fa-bolt"
			when "cancelamento"
				tipo = "notification-danger"
				icone = "fa fa-thumbs-down"
			when "confirmacao"
				tipo = "notification-success"
				icone = "fa fa-car"
			when "problema"
				tipo = "notification-failure"
				icone = "fa fa-times-circle"
			end
			
			
			if notificacao.objeto_type == "Requisicao" and notificacao.tipo == "aviso"
				url = "#{gerencia_controle_requisicoes_detalhes_requisicao_url(:requisicao_id=>notificacao.objeto.id,:notificacao_id=>notificacao.id)}" 
			elsif notificacao.objeto_type == "Requisicao" and notificacao.tipo == "cancelamento"
				url = "#{requisicao_url(notificacao.objeto_id,:notificacao=>notificacao.id)}"
			elsif notificacao.objeto_type == "Requisicao" and notificacao.tipo == "confirmacao"
				url = "#{requisicao_url(notificacao.objeto_id,:notificacao=>notificacao.id)}"
			end

			html+="<li><a href='#{url}' class='#{tipo}'>"
			html+="<span class='hora'>#{tempo_relativo(notificacao.created_at)}</span>"
			html+="<i class='#{icone}'></i>"
			html+="<span class='msg'>#{notificacao.texto}</span></a></li>"
		end
		return raw(html)
	end

end
