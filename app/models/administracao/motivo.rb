class Administracao::Motivo < ActiveRecord::Base
  belongs_to :tipo
  belongs_to :lote
end
