# -*- encoding : utf-8 -*-
class Administracao::Rota < ActiveRecord::Base
  belongs_to :roteavel,:polymorphic=>true

  has_and_belongs_to_many :requisicoes,:class_name=>"Requisicao"

#after_validation :setar_rota

private
  def setar_rota
  	self.latitude = self.roteavel.endereco.latitude
  	self.longitude = self.roteavel.endereco.longitude
  end

end
