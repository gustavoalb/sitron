# -*- encoding : utf-8 -*-
module SitronHelper


def form_sitron(titulo,sub_titulo,tam,&block)
html = ''

html+="<div class='col-md-#{tam}'>"
html+="<div class='box box-primary'>"
html+="<div class='box-header'>"
html+="<h3 class='box-title'>#{sub_titulo}</h3>"
html+="</div>"
html+="<div class='box-body'>"

html+=capture(&block)

html+="</div>"



html+="</div>"

titulo_pagina(titulo,nil)

return raw(html)


end



def botoes_form(form)
html=""

html+="<div class='panel-footer'>"
html+="<div class='row'>"
html+="<div class='col-sm-6 col-sm-offset-3'>"
html+="<div class='btn-toolbar'>"
html+="#{form.submit "Salvar",:class=>"btn btn-primary"} ou #{link_to 'Cancelar',:back}"
html+="</div>"
html+="</div>"
html+="</div>"
html+="</div>"
return raw(html)
end


def nav_item_menu(titulo,controller,icone,badge=nil,valor_badge=nil,&block)
  html=""
  if controller.is_a? Array
    controller.each do |c|
        if c == controller_name
          html+="<li class='hasChild active'>"
          html+="<a href='javascript:;''><i class='fa fa-#{icone}'></i> <span>#{titulo}</span> <span class='badge badge-#{badge}'>#{valor_badge}</span></a>"
          break
        else
          html+="<li class='hasChild'>"
          html+="<a href='javascript:;''><i class='fa fa-#{icone}'></i> <span>#{titulo}</span> <span class='badge badge-#{badge}'>#{valor_badge}</span></a>"
        end
    end

  else

     if controller == controller_name
        html+="<li class='hasChild active'>"
        html+="<a href='javascript:;''><i class='fa fa-#{icone}'></i> <span>#{titulo}</span> <span class='badge badge-#{badge}'>#{valor_badge}</span></a>"
     else
        html+="<li class='hasChild'>"
        html+="<a href='javascript:;''><i class='fa fa-#{icone}'></i> <span>#{titulo}</span> <span class='badge badge-#{badge}'>#{valor_badge}</span></a>"
     end
  end



  html+="<ul class='acc-menu'>"
  html+=capture(&block)
  html+="</ul>"
  html+="</li>"

  return raw(html)
end

def nav_item(url,titulo,controller,action,icone=nil)

  html=""
  if action == action and  controller_name == controller
    html+="<li class='active'>#{link_to link_icone(titulo,icone),url,data: { no_turbolink: true }}</li>"
  else
    html+="<li>#{link_to link_icone(titulo,icone),url,data: { no_turbolink: true }}</li>"
  end
  raw(html)
end





def nav_item_submenu(titulo,controller,icone,badge=nil,valor_badge=nil,&block)
  html=""



  html+="<ul class='acc-menu active'>"
  html+=capture(&block)
  html+="</ul>"


  return raw(html)
end




end
