class Administracao::Contrato < ActiveRecord::Base
  belongs_to :empresa


  def codigo_contrato
    code =  self.id.to_s
    case code.chars.count
    when 1
      code_mod = "0000#{code}"
    when 2
      code_mod = "000#{code}"
    when 3
      code_mod = "00#{code}"
    when 4
      code_mod = "0#{code}"
    else
      code_mod = "#{code}"
    end
    return code_mod
  end

end
