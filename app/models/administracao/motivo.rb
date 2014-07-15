class Administracao::Motivo < ActiveRecord::Base
  belongs_to :tipo
  belongs_to :lote

  enum tipo_requisicao: [:normal,:urgente,:agendada]
  

end
