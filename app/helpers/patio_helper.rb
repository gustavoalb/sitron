module PatioHelper

	def broadcast(channel, &block)
		message = { channel: channel, data: capture(&block) }
		uri     = URI.parse("http://localhost:3000/patio")
		Net::HTTP.post_form(uri, message: message.to_json)
	end

	def lista(tipo,subtipo,obj)
		html="<span class='#{tipo} #{tipo}-#{subtipo}'>"
		html +="#{obj}"
		html+= "</span>"
		return raw(html)
	end

	def veiculo_patio(url,tile,patio,veiculo)
		case patio.state
		when "estacionado"
			@tile = 'success'
		when "saida_proxima"
			@tile = 'primary'
		when "em_transito"
			@tile = 'warning'
		when "com_problema"
			@tile = 'danger'
		when "agendado"
			@tile = 'info'
		end
		html = ""
		html+="<div class='col-md-2' id='posto_#{veiculo.id}'>"
		html+="<a href='#{url}' class='shortcut-tiles tiles-#{@tile}'>"
		html+="<div class='tiles-body'>"
		html+="<div class='pull-left'><i class='fa fa-car'></i></div>"
		html+="<div class='pull-right'><span class='badge'>#{patio.position}</span><span class='badge'>#{veiculo.placa}</span></div>"
		html+="<div class='pull-right'></div>"
		html+="</div>"
		html+="<div class='tiles-footer'>#{veiculo.tipo.titleize}-#{veiculo.modelo.titleize}</div>"
		html+="</a>"
		html+="</div>"
		return raw(html)
	end



	def veiculo_patio_all(patios,url,tile)
				html = ""
	 patios.each do |patio|			
	 	veiculo = patio.veiculo
		case patio.state
		when "estacionado"
			@tile = 'success'
		when "saida_proxima"
			@tile = 'primary'
		when "em_transito"
			@tile = 'warning'
		when "com_problema"
			@tile = 'danger'
		when "agendado"
			@tile = 'info'
		end

		html+="<div class='col-md-2' id='posto_#{veiculo.id}'>"
		html+="<a href='#{url}' class='shortcut-tiles tiles-#{@tile}'>"
		html+="<div class='tiles-body'>"
		html+="<div class='pull-left'><i class='fa fa-car'></i></div>"
		html+="<div class='pull-right'><span class='badge'>#{patio.position}</span><span class='badge'>#{veiculo.placa}</span></div>"
		html+="<div class='pull-right'></div>"
		html+="</div>"
		html+="<div class='tiles-footer'>#{veiculo.tipo.titleize}-#{veiculo.modelo.titleize}</div>"
		html+="</a>"
		html+="</div>"
	end
		return raw(html)
	end





	def veiculo_patio_ex(veiculo_id)
		veiculo = Administracao::Veiculo.find(veiculo_id.to_i)
		patio = veiculo.patios.na_data(Time.now).last
		html = ""
		html+="<div class='col-md-2' id='posto_#{veiculo.id}'>"
		html+="<a href='#' class='shortcut-tiles tiles-success'>"
		html+="<div class='tiles-body'>"
		html+="<div class='pull-left'><i class='fa fa-car'></i></div>"
		html+="<div class='pull-right'><span class='badge'>#{patio.position}</span><span class='badge'>#{veiculo.tipo.titleize}</span><span class='badge'>#{veiculo.placa}</span></div>"
		html+="<div class='pull-right'></div>"
		html+="</div>"
		html+="<div class='tiles-footer'>#{veiculo.empresa.nome}</div>"
		html+="</a>"
		html+="</div>"
		return raw(html)
	end
end
