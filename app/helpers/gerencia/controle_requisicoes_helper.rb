# -*- encoding : utf-8 -*-
module Gerencia::ControleRequisicoesHelper

	def lista_requisicoes(requisicoes)
		html = ""

		html += "<div class='dd' id='nestable_list_1'>"
		html += "<ol class='dd-list'>"
		requisicoes.each do |r|
			html += "<li class='dd-item dd3-item' id='draggable_demo_#{r.id}' data-id='#{r.id}'>"
			html += "<div class='dd-handle dd3-handle'></div>"
			html += "<div class='dd3-content'>#{r.id} - #{r.requisitante.nome} - #{r.data_ida.to_s_br} - #{r.hora_ida.strftime('%H:%M')}: #{r.state}</div>"
		end

		html += "</ol>"
		html += "</div>"
           
		raw(html)
	end


	def modal(id,titulo_modal,r,&block)
        html=""
		html+="<div style='display: none;' class='modal fade' id='#{id}' tabindex='-1' role='dialog' aria-labelledby='myModalLabel' aria-hidden='true'>"
		html+="<div class='modal-dialog modal-lg'>"
		html+="<div class='modal-content'>"
		html+="<div class='modal-header'>"
		html+="<button type='button' class='close' data-dismiss='modal' aria-hidden='true'>×</button>"
		html+="<h4 class='modal-title'>#{titulo_modal}</h4></div>"

		html+="<div class='modal-body'>#{capture(&block)}</div>"

		html+="<div class='modal-footer'>"
		html+="<button type='button' class='btn btn-default' data-dismiss='modal'>Cancelar</button>"
		html+="</div>"
		html+="</div>"
		html+="</div>"
		html+="</div>"
        return raw(html)
	end

		def modal_sm(id,titulo_modal,r,&block)
        html=""
		html+="<div style='display: none;' class='modal fade' id='#{id}' tabindex='-1' role='dialog' aria-labelledby='myModalLabel' aria-hidden='true'>"
		html+="<div class='modal-dialog modal-sm'>"
		html+="<div class='modal-content'>"
		html+="<div class='modal-header'>"
		html+="<button type='button' class='close' data-dismiss='modal' aria-hidden='true'>×</button>"
		html+="<h4 class='modal-title'>#{titulo_modal}</h4></div>"

		html+="<div class='modal-body'>#{capture(&block)}</div>"

		html+="<div class='modal-footer'>"
		html+="<button type='button' class='btn btn-default' data-dismiss='modal'>Cancelar</button>"
		html+="</div>"
		html+="</div>"
		html+="</div>"
		html+="</div>"
        return raw(html)
	end



		def modal_simples(id,titulo_modal,&block)
        html=""
		html+="<div style='display: none;' class='modal fade' id='#{id}' tabindex='-1' role='dialog' aria-labelledby='myModalLabel' aria-hidden='true'>"
		html+="<div class='modal-dialog modal-lg'>"
		html+="<div class='modal-content'>"
		html+="<div class='modal-header'>"
		html+="<button type='button' class='close' data-dismiss='modal' aria-hidden='true'>×</button>"
		html+="<h4 class='modal-title'>#{titulo_modal}</h4></div>"
		html+="<div class='modal-body'>#{capture(&block)}</div>"
		html+="</div>"
		html+="</div>"
		html+="</div>"
        return raw(html)
    end


  def tipo_requisicao(r)
    html=''
    case r.tipo_requisicao
      when 'normal'
        html="<span class='badge badge-success'>Normal</span>"
      when 'urgente'
        html="<span class='badge badge-warning'>Urgente</span>"
      when 'agendada'
        html="<span class='badge badge-primary'>Agendada</span>"
      when 'especial'
        html="<span class='badge badge-info'>Especial</span>"
      when 'fim_de_semana'
        html="<span class='badge badge-default'>Fim de Semana</span>"
    end
    return raw(html)
  end

  def info_veiculo_alt(v)
     m = v.modalidade
    s = Time.zone.now.strftime("%U")
    mes = Time.zone.now.month
    ano = Time.zone.now.year
    return raw("#{link_icone('',icone_lote(v))}#{m.periodo_diario}H#{m.dias_mes} #{v.placa}")

  end

end
