module RequisicoesHelper


	def item_requisicao(parent,id,titulo,&block)
		html=""
		html+="<div class='panel panel-default'>"
		html+="<a class='collapsed' data-toggle='collapse' data-parent='##{parent}' href='##{id}'>"
		html+="<div class='panel-heading'><h4>#{titulo}</h4></div>"
		html+="</a>"
		html+="<div style='height: 0px;' id='#{id}' class='panel-collapse collapse'>"
		html+="<div class='panel-body'>"
		html+=capture(&block)
		html+="</div>"
		html+="</div>"
		html+="</div>"
		return raw(html)
	end
def status_requisicao(req)
html=""
html+="<span class='badge badge-primary'>#{req.state.upcase}</span>" 
return raw(html)
end


def direito_menu_req(req)
color = ''
html = ''
case req.panel
when 'default'
	color = '#bebebe'
when 'success'
	color = '#85c744'
when 'danger'
	color = '#e73c3c'
when 'info'
	color = '#2bbce0'
end

html+="<div class='widget-block' style='background: #{color}; margin-top:10px;'>"
html+="<div class='pull-left'>"
html+="<small>#{req.motivo}</small>"
html+="<h5>#{req.state.upcase}</h5>"
html+="</div>"
html+="<div class='pull-right'>"
html+="<small class='text-right'>#{req.created_at.strftime('%B')}</small>"
html+="<h5>#{req.created_at.day}</h5>"
html+="</div>"
html+="</div>"
return raw(html)

end


def even_odd(req)
  html=""
  if req.even?
  	html+="even"
  else
  	html+="odd"
  end
  return raw(html)
end
end
