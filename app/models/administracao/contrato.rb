# -*- encoding : utf-8 -*-
class Administracao::Contrato < ActiveRecord::Base
  belongs_to :empresa


  def codigo_contrato
    code =  self.id.to_s
    case code.chars.count
    when 1
      code_mod = "00#{code}"
    when 2
      code_mod = "0#{code}"
    else
      code_mod = "#{code}"
    end
    return code_mod
  end


def vigencia 
 "de #{self.inicio_vigencia.to_s_br} até #{self.fim_vigencia.to_s_br}"
end
end
