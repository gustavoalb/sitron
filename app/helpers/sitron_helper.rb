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

html+="<div class='box-footer'>"
html+="#{form.submit "Salvar",:class=>"btn btn-primary"} ou #{link_to 'Cancelar',:back}"
html+="</div>"
return raw(html)
end



def tabela_sitron(titulo,sub_titulo,objetos,&block)
html = ""
html+="<div class='box'>"
html+="<div class='box-header'>"
html+="<h3 class='box-title'>#{sub_titulo}</h3>"
html+="<div class='box-tools'>"
 html+=paginate objetos 
html+="</div>"
html+="</div>"
html+="<div class='box-body no-padding'>"
html+=capture(&block)
html+="</div>"
html+="</div>"

titulo_pagina(titulo,nil)

return raw(html)
end
end
