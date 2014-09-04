# -*- encoding : utf-8 -*-
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


	def cor_posto(posto)
		if posto.veiculo.especial
			@tile = "green"
		else
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
		end

		return @tile

	end

	def veiculo_posto(url,tile,posto,veiculo)
		s = Time.zone.now.strftime("%U")
		mes = Time.zone.now.month
		ano = Time.zone.now.year
		@tile = cor_posto(posto)

		html = ""
		html+="<div class='col-md-2' id='posto_#{posto.id}'>"
		html+="<a href='#info_posto_#{posto.id}' class='info-tiles tiles-#{@tile}' data-toggle='modal'>"
		html+="<div class='tiles-heading'>"
		html+="<div class='pull-left'>#{posto.veiculo.lote.tipo.remover_acentos.upcase}::#{posto.veiculo.position}"
		html+="</div>"
		html+="<div class='pull-right'></div></div>"
		html+="<div class='tiles-body'>"
		html+="<div class='pull-left'><i class='#{icone_lote(posto)}'></i></div>"
		html+="<div class='pull-right'><span class='badge badge-#{@tile}'>#{posto.veiculo.horas_extras_semanais(s,ano).to_i}</span></div>"
		html+="<div class='pull-right'></div>"
		html+="</div>"
		html+="<div class='tiles-footer'>#{info_posto(posto)}</div>"
		html+="</a>"
		html+="</div>"

		html+="<div class='modal fade' tabindex='-1' role='dialog' aria-labelledby='myModalLabel' aria-hidden='true' id='info_posto_#{posto.id}'>"
		html+="<div class='modal-dialog'>"
		html+="<div class='modal-content'>"
		html+="<div class='modal-header'>"
		html+="<button type='button' class='close' data-dismiss='modal'><span aria-hidden='true'>&times;</span><span class='sr-only'>Close</span></button>"
		html+="<h4 class='modal-title' id='myModalLabel'>Informações do Posto #{info_posto(posto)} no dia #{Time.now.day} de #{Time.now.strftime('%B')} de #{Time.now.year}</h4></div>"
		html+="<div class='modal-body'>"
		html+="<dl class='dl-vertical'>"
		html+=informacao('Tipo do Veículo',posto.veiculo.lote.tipo)
		html+=informacao('Placa do Veículo',posto.veiculo.placa)
		html+=informacao('Motorista',posto.veiculo.motorista)
		html+=informacao('Horas Normais na Semana',posto.veiculo.horas_normais_semanais(Time.now.strftime("%U"),Time.now.year).round(2))
		html+=informacao('Horas Extras na Semana',posto.veiculo.horas_extras_semanais(Time.now.strftime("%U"),Time.now.year).round(2))
		if posto.saida_proxima? or posto.em_transito? 
			r = Requisicao.do_posto(posto).first
			if r
				html+="<h4>Informações da Requisição <small>#{r.numero}</small></h4>"
				html+="<hr/>"
				html+=informacao("Requisitante",r.requisitante.nome)
				html+=informacao("Departamento",detalhes(r.requisitante.departamento,:nome))
				html+=informacao("Período",r.periodo_completo_da_requisicao)
				html+=informacao("Motivo da Requisição",r.motivo.nome)
				html+=informacao("Descrição da Requisição",r.descricao)
				html+=link_to link_icone("Saída para Serviço", 'car'), gerencia_controle_requisicoes_saida_servico_path(:requisicao_id => r.id), :class => "btn btn-sky btn-xs", :remote => true, :method => :post if r.confirmada?
				html+=link_to link_icone("Desfazer Definição de Posto", 'thumbs-down'), gerencia_controle_requisicoes_cancelar_posto_path(:requisicao_id => r.id), :class => "btn btn-danger btn-xs", :method => :post
				html+=link_to link_icone("Retorno do Serviço",'car'),gerencia_controle_requisicoes_chegada_servico_path(:requisicao_id=>r.id), :class=>"btn btn-sky btn-xs",:remote=>true,:method=>:post if r.ativa?
			end
		end



		html+="</dl>"
		html+="</div>"
		html+="<div class='modal-footer'>"
		html+="<button type='button' class='btn btn-default' data-dismiss='modal'>Fechar</button>"
		html+="</div>"
		html+="</div>"
		html+="</div>"
		html+="</div>"
		

		return raw(html)
	end


	def informacao(titulo,info)
		html="<dt>#{titulo}</dt>"
		html+="<dd>#{info}</dd>"
		return raw(html)
	end


	def veiculo_posto_all(postos,url,tile)
		s = Time.zone.now.strftime("%U")
		mes = Time.zone.now.month
		ano = Time.zone.now.year
		html = ""
		postos.each do |posto|			
			veiculo = posto.veiculo
			@tile = cor_posto(posto)

			html+="<div class='col-md-2' id='posto_#{posto.id}'>"
			html+="<a href='#{url}' class='info-tiles tiles-#{@tile}'>"
			html+="<div class='tiles-heading'>"
			html+="<div class='pull-left'>#{posto.veiculo.lote.tipo.remover_acentos.upcase}::#{posto.veiculo.position}</div>"
			html+="<div class='pull-right'></div></div>"
			html+="<div class='tiles-body'>"
			html+="<div class='pull-left'><i class='#{icone_lote(posto)}'></i></div>"
			html+="<div class='pull-right'><span class='badge badge-#{@tile}'>#{posto.veiculo.horas_extras_semanais(s,ano).to_i}</span></div>"
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
		return "#{m.periodo_diario}H#{m.dias_mes}#{posto.position}/#{v.lote.numero_postos}".upcase

	end


	def info_posto_alt(posto)
		v = posto.veiculo
		m = v.modalidade
		s = Time.zone.now.strftime("%U")
		mes = Time.zone.now.month
		ano = Time.zone.now.year
		return raw("#{link_icone('',icone_lote(posto))}#{m.periodo_diario}H#{m.dias_mes} #{v.placa}")

	end



	def info_posto_print(posto)
		v = posto.veiculo
		m = v.modalidade
		s = Time.zone.now.strftime("%U")
		mes = Time.zone.now.month
		ano = Time.zone.now.year
		return raw("#{posto.veiculo.lote.tipo.upcase}#{m.periodo_diario}H#{m.dias_mes} #{v.position}/#{v.lote.numero_postos}")

	end



	def info_veiculo(veiculo)
		m = veiculo.modalidade
		s = Time.zone.now.strftime("%U")
		mes = Time.zone.now.month
		ano = Time.zone.now.year
		return raw("#{veiculo.lote.tipo}::#{m.periodo_diario}H#{m.dias_mes} #{veiculo.position}/#{veiculo.lote.numero_postos} HE#{veiculo.horas_extras_semanais(s,ano).to_i}")

	end




	def veiculo_posto_ex(veiculo_id)
		veiculo = Administracao::Veiculo.find(veiculo_id.to_i)
		posto = veiculo.postos.na_data(Time.now).last
		html = ""
		html+="<div class='col-md-2' id='posto_#{veiculo.id}'>"
		html+="<a href='po' class='shortcut-tiles tiles-success'>"
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

	def menu_nav(sub=nil,&block)
		if sub 
			html="<ul id='menu3' class='dropdown-menu' role='menu' aria-labelledby='drop6'>"
		else
			html="<ul class='nav nav-pills'>"
		end
		html+=capture(&block)
		html+="</ul>"
		return raw(html)
	end

	def menu_item_nav(titulo, url,&block)
		html = "<li class='dropdown'>"
		if block_given?
			html+=link_to titulo, url, role: "button",:'data-toggle'=>"dropdown"
			html+=capture(&block)
		else
			html+=link_to titulo,url,role: "menuitem",tabindex: "-1"
		end
		html+="</li>"
		return raw(html)
	end

end
