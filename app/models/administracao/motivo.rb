class Administracao::Motivo < ActiveRecord::Base
  belongs_to :tipo
  belongs_to :lote
  scope :urgentes,->{where("urgente = true")}
  scope :normais,->{where("urgente = false")}
  enum tipo_carga: ["Mobiliário Escolar","Livros Didáticos","ETC"]


  
end
