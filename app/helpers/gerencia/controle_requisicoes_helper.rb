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
		html+="<div class='modal-dialog'>"
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
end
