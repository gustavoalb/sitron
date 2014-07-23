class Administracao::Escola < ActiveRecord::Base
  belongs_to :municipio,:class_name=>"Cidade"
  has_one :endereco,:as=>:enderecavel,:dependent=>:destroy
  has_one :rota, :as=>:roteavel,:dependent=>:destroy
  after_create :adicionar_rota

  
  private



  def adicionar_rota
		rota = self.create_rota(:latitude=>self.endereco.latitude,:longitude=>self.endereco.longitude,:destino=>"#{self.nome}")
  end

end
