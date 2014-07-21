class Avaliacao < ActiveRecord::Base
  belongs_to :requisicao
  belongs_to :avaliador,:class_name=>"User"

  enum :tipo=>[:positiva,:negativa,:problemas]
end
