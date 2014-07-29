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
		s = Time.zone.now.strftime("%U")
		mes = Time.zone.now.month
		ano = Time.zone.now.year
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
		html+="<a href='#{url}' class='info-tiles tiles-#{@tile}'>"
		html+="<div class='tiles-heading'>"
		html+="<div class='pull-left'>#{posto.position}</div>"
		html+="<div class='pull-right'>#{posto.lote.tipo}</div></div>"
		html+="<div class='tiles-body'>"
		html+="<div class='pull-left'><i class='#{icone_lote(posto)}'></i></div>"
		html+="<div class='pull-right'><span class='badge badge-#{@tile}'>#{posto.veiculo.horas_extras_semanais(s,mes,ano)}</span></div>"
		html+="<div class='pull-right'></div>"
		html+="</div>"
		html+="<div class='tiles-footer'>#{info_posto(posto)}</div>"
		html+="</a>"
		html+="</div>"
		return raw(html)
	end



	def veiculo_posto_all(postos,url,tile)
		s = Time.zone.now.strftime("%U")
		mes = Time.zone.now.month
		ano = Time.zone.now.year
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
			html+="<a href='#{url}' class='info-tiles tiles-#{@tile}'>"
			html+="<div class='tiles-heading'>"
			html+="<div class='pull-left'>#{posto.position}</div>"
			html+="<div class='pull-right'>#{posto.lote.tipo}</div></div>"
			html+="<div class='tiles-body'>"
			html+="<div class='pull-left'><i class='#{icone_lote(posto)}'></i></div>"
		    html+="<div class='pull-right'><span class='badge badge-#{@tile}'>#{posto.veiculo.horas_extras_semanais(s,mes,ano)}</span></div>"
 			html+="<div class='pull-right'></div>"
			html+="</div>"
			html+="<div class='tiles-footer'>#{info_posto(posto)}</div>"
			html+="</a>"
			html+="</div>"
		end
		return raw(html)
	end


	def info_posto(posto)
		v = posto.veiculo
		m = v.modalidade
		return "#{m.periodo_diario}H#{m.dias_mes}d#{v.lote.tipo.upcase}#{posto.position}/#{v.lote.numero_postos}".upcase

	end


	def info_posto_alt(posto)
		v = posto.veiculo
		m = v.modalidade
		s = Time.zone.now.strftime("%U")
		mes = Time.zone.now.month
		ano = Time.zone.now.year
		return "#{m.periodo_diario}H#{m.dias_mes}d#{v.lote.tipo.upcase}#{posto.veiculo.horas_extras_semanais(s,mes,ano)}".upcase

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
		case posto.lote.tipo
		when "Passeio"
			html += 'fa fa-passeio'
		when "Pick-up"
			html += 'fa fa-pickup'
		when "Motocicleta"
			html += 'fa fa-motocicleta'
		when "Caminhão"
			html += 'fa fa-caminhao'
		when "Van"
			html += 'fa fa-van'
		when "Kombi"
			html += 'fa fa-kombi'
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
