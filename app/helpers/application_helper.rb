# -*- encoding : utf-8 -*-
module ApplicationHelper

  def display_base_errors resource
    return '' if (resource.errors.empty?) or (resource.errors[:base].empty?)
    messages = resource.errors[:base].map { |msg| content_tag(:p, msg) }.join
    html = <<-HTML
    <div class="alert alert-error alert-block">
      <button type="button" class="close" data-dismiss="alert">&#215;</button>
      #{messages}
    </div>
    HTML
    html.html_safe
  end


  def titulo_pagina(titulo,sub_titulo)
    html = ""
    html2 = ""
    html += "#{titulo}"
    html2 += "#{sub_titulo}"

    content_for :titulo do
      raw(html)
    end

    content_for :sub_titulo do
      raw(html2)
    end

  end


  def link_icone(texto,icone=nil,local=nil)
  if icone
    if local
      if local=='direita'
        html="#{texto} <i class='fa fa-#{icone}'></i>"
      elsif local=='esquerda'
        html="<i class='fa fa-#{icone}'></i> #{texto}"
      end
    else
     html="<i class='fa fa-#{icone}'></i> #{texto}"
   end
 else
  case texto
  when 'detalhes'
    html="<i class='fa fa-eye'></i> Detalhes"
  when 'editar'
    html="<i class='fa fa-edit'></i> Editar"
  when 'apagar'
    html="<i class='fa fa-trash-o fa fa-white'></i> Apagar"
  when 'excluir'
    html="<i class='fa fa-minus-sign'></i> Excluir"
  when 'salvar'
    html="<i class='fa fa-hdd'></i> Salvar"
  when 'voltar'
    html="<i class='fa fa-arrow-left'></i> Voltar"
  when 'cancelar'
    html="<i class='fa fa-refresh'></i> Cancelar"
  when 'novo'
    html="<i class='fa fa-plus-sign'></i> Novo"
  end
end

return raw(html)
end


  def link_icone_ion(texto,icone=nil,local=nil)
  if icone
    if local
      if local=='direita'
        html="#{texto} <i class='ion ion-#{icone}'></i>"
      elsif local=='esquerda'
        html="<i class='ion ion-#{icone}'></i> #{texto}"
      end
    else
     html="<i class='ion ion-#{icone}'></i> #{texto}"
   end
 else
  case texto
  when 'detalhes'
    html="<i class='ion ion-eye-open'></i> Detalhes"
  when 'editar'
    html="<i class='ion ion-edit'></i> Editar"
  when 'apagar'
    html="<i class='ion ion-trash ion ion-white'></i> Apagar"
  when 'excluir'
    html="<i class='ion ion-minus-sign'></i> Excluir"
  when 'salvar'
    html="<i class='ion ion-hdd'></i> Salvar"
  when 'voltar'
    html="<i class='ion ion-arrow-left'></i> Voltar"
  when 'cancelar'
    html="<i class='ion ion-refresh'></i> Cancelar"
  when 'novo'
    html="<i class='ion ion-plus-sign'></i> Novo"
  end
end

return raw(html)
end




def icone_dash(titulo,contador,icone_ion,link_titulo,icone,color,link=nil,subtitulo=nil)
html = ""
html+="<div class='col-md-3 col-xs-12 col-sm-6'>"
html+="<a class='info-tiles tiles-#{color}' href='#{link}'>"
html+="<div class='tiles-heading'>#{titulo}</div>"
html+="<div class='tiles-body-alt'>"
html+="<i class='ion ion-#{icone_ion}'></i>"
html+="<div class='text-center'>#{contador}</div>"
html+="<small>#{subtitulo}</small>"
html+="</div>"
html+="<div class='tiles-footer'>Mais Informações</div>"
html+="</a>"
html+="</div>"

return raw(html)
end










def yield_or(name, content = nil, &block)
  if content_for?(name)
    content_for(name)
  else
    block_given? ? capture(&block) : content
   end
end

end
