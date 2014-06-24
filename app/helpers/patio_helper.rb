module PatioHelper

	def broadcast(channel, &block)
		message = { channel: channel, data: capture(&block) }
		uri     = URI.parse("http://localhost:3000/posto")
		Net::HTTP.post_form(uri, message: message.to_json)
	end

	def lista(tipo,subtipo,obj)
		html="<span class='#{tipo} #{tipo}-#{subtipo}'>"
		html +="#{obj}"
		html+= "</span>"
		return raw(html)
	end

	def veiculo_posto(url,tile,posto,veiculo)
		case posto.state
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
		html+="<div class='col-md-2' id='posto_#{posto.id}'>"
		html+="<a href='#{url}' class='shortcut-tiles tiles-#{@tile}'>"
		html+="<div class='tiles-body'>"
		html+="<div class='pull-left'><i class='#{icone_lote(posto)}'></i></div>"
		html+="<div class='pull-right'><span class='badge'>#{posto.lote.nome}</span> <span class='badge'>#{posto.position}</span></div>"
		html+="<div class='pull-right'></div>"
		html+="</div>"
		html+="<div class='tiles-footer'>#{posto.contrato.numero}</div>"
		html+="</a>"
		html+="</div>"
		return raw(html)
	end



	def veiculo_posto_all(postos,url,tile)
		html = ""
		postos.each do |posto|			
			veiculo = posto.veiculo
			case posto.state
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

			html+="<div class='col-md-2' id='posto_#{posto.id}'>"
			html+="<a href='#{url}' class='shortcut-tiles tiles-#{@tile}'>"
			html+="<div class='tiles-body'>"
			html+="<div class='pull-left'><i class='#{icone_lote(posto)}'></i></div>"
			html+="<div class='pull-right'><span class='badge'>#{posto.lote.nome}</span> <span class='badge'>#{posto.position}</span></div>"
			html+="<div class='pull-right'></div>"
			html+="</div>"
			html+="<div class='tiles-footer'>#{posto.contrato.numero}</div>"
			html+="</a>"
			html+="</div>"
		end
		return raw(html)
	end





	def veiculo_posto_ex(veiculo_id)
		veiculo = Administracao::Veiculo.find(veiculo_id.to_i)
		posto = veiculo.postos.na_data(Time.now).last
		html = ""
		html+="<div class='col-md-2' id='posto_#{veiculo.id}'>"
		html+="<a href='#' class='shortcut-tiles tiles-success'>"
		html+="<div class='tiles-body'>"
		html+="<div class='pull-left'><i class='fa fa-car'></i></div>"
		html+="<div class='pull-right'><span class='badge'>#{posto.position}</span><span class='badge'>#{veiculo.tipo.nome}</span><span class='badge'>#{veiculo.placa}</span></div>"
		html+="<div class='pull-right'></div>"
		html+="</div>"
		html+="<div class='tiles-footer'>#{veiculo.empresa.nome}</div>"
		html+="</a>"
		html+="</div>"
		return raw(html)
	end


	def icone_lote(posto)
		html=''
		case posto.lote.nome
		when "Lote 01"
			html += 'fa fa-car'
		when "Lote 02"
			html += 'fa fa-car'
		when "Lote 03"
			html += 'fa fa-car'
		when "Lote 04"
			html += 'fa fa-truck'
		when "Lote 05"
			html += 'fa fa-car'
		when "Lote 06"
			html += 'fa fa-car'
		when "Lote 07"
			html += 'fa fa-car'
		when "Lote único"
			html += 'fa fa-car'
		else
			html += 'fa fa-car'
		end
		return html
	end
end
