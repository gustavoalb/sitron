# -*- encoding : utf-8 -*-
class MultiSelectInput < SimpleForm::Inputs::Base
  def input
    out = ''
    out << "<div class='checkbox block'>"
    out << @builder.hidden_field(attribute_name, value: 0).html_safe
    out << @builder.check_box(attribute_name,{},1,nil)
    out << "</div>"
    out
  end
end
