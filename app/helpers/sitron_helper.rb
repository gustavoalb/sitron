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
    html+="#{form.submit "Salvar",:class=>"btn btn-primary"} ou #{link_to 'Cancelar',:back,:class=>"btn btn-warning"}"
    html+="</div>"
    html+="</div>"
    html+="</div>"
    html+="</div>"
    return raw(html)
  end


  def sigla_destino(destino)
    if destino.roteavel.respond_to? "sigla" 
      return destino.roteavel.sigla.upcase 
    else
      destino.destino.downcase.camelcase
    end
  end


  def botoes_form_alt(form,titulo)
    html=""

    html+="<div class='panel-footer'>"
    html+="<div class='row'>"
    html+="<div class='col-sm-6 col-sm-offset-3'>"
    html+="<div class='btn-toolbar'>"
    html+="#{form.submit titulo,:class=>"btn btn-primary"} ou #{link_to 'Cancelar',:back,:class=>"btn btn-warning"}"
    html+="</div>"
    html+="</div>"
    html+="</div>"
    html+="</div>"
    return raw(html)
  end



  def botoes_form_modal(form,titulo)
    html=""

    html+="<div class='modal-footer'>"
    html+="<button type='button' class='btn btn-default' data-dismiss='modal'>Cancelar</button>"
    html+="#{form.submit titulo,:class=>"btn btn-primary"}"
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
  icone = "<i class='fa fa-#{icone}'></i>"

  html=""
  if action == action and  controller_name == controller
    html+="<li class='active'><a href='#{url}' data-no-turbolink='true'>#{icone} <span>#{titulo}</span></a></li>"
  else
    html+="<li class=""><a href='#{url}' data-no-turbolink='true'>#{icone} <span>#{titulo}</span></a></li>"
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
