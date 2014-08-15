# -*- encoding : utf-8 -*-
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


	def broadcast(channel, &block)
		message = { channel: channel, data: capture(&block) }
		uri     = URI.parse("http://localhost:3000/gps")
		Net::HTTP.post_form(uri, message: message.to_json)
	end



	def mensagens_usuario(mensagens)
		html = ""
		html+="<li class='dropdown'>"
		html+="<a href='#' class='hasnotifications dropdown-toggle' data-toggle='dropdown' id='mensagens'><i class='fa fa-envelope'></i>"
		html+="<div id='contador'>"
		if mensagens.count > 0
			html+="<span class='badge'>#{mensagens.count}</span>"
		end
		html+="</div>"
		html+="</a>"

		html+="<ul class='dropdown-menu messages arrow'>"
		html+="<li class='dd-header'>"
		html+="<div id='header_mensagem'>"
		if mensagens.count > 0
			html+="<span>Você tem #{mensagens.count} #{'nova'.pluralize(mensagens.count)} #{'mensagem'.pluralize(mensagens.count)}</span>"
			html+="<span>#{link_to 'Marcar tudo como lida',marcar_lida_mensagens_url,:method=>:post,:remote=>true}</span>"
		else
			html+="<span>Nenhuma nova Mensagem</span>"
		end
		html+="</div>"
		html+="</li>"

		html+="<div class='scrollthis'>"
		
		html+="<div id='lista_mensagens'>"
		mensagens.limit(3).each do |m|
			html+="<li><a href='/mensagens/#{m.id}/ler' class='active'>"
			html+="<span class='hora'>#{tempo_relativo(m.created_at)}</span>"
			if m.remetente
				html+=image_tag(m.remetente.avatar_url(:avatar))
				html+="<div><span class='name'>#{remetente(m)}</span><span class='msg'>#{m.texto.truncate(10)}</span></div>"
			else
				html+="<div><span class='name'>#{remetente(m)}</span><span class='msg'>#{m.texto.truncate(10)}</span></div>"
			end
			html+="</a></li>"
		end
		html+="</div></div>"
		html+="<li class='dd-footer'>#{link_page(mensagens_url,'Ver todas as Mensagens','eye')}</li>"
		html+="<li class='dd-footer'>#{link_to link_icone('Nova Mensagem','envelope'),new_mensagem_url,:class=>'notification-success active'}</li>"
		html+="</ul>"
		html+="</li>"

		return raw(html)
	end

	def lista_mensagems(mensagens)
		html = ""
		mensagens.each do |m|
			html+="<li><a href='/mensagens/#{m.id}/ler' class='active'>"
			html+="<span class='hora'>#{tempo_relativo(m.created_at)}</span>"
			if m.remetente
				html+=image_tag(m.remetente.avatar_url(:avatar))
				html+="<div><span class='name'>#{remetente(m)}</span><span class='msg'>#{m.texto.truncate(10)}</span></div>"
			else
				html+="<div><span class='name'>#{remetente(m)}</span><span class='msg'>#{m.texto.truncate(10)}</span></div>"
			end
			html+="</a></li>"
		end
		return raw(html)
	end

end
