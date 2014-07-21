class Administracao::Escola < ActiveRecord::Base
  has_one :rota, :as=>:roteavel
  belongs_to :municipio,:class_name=>"Cidade"
  has_one :endereco,as: :enderecavel

  


  #private

  def adicionar_rota
		rota = self.create_rota(:latitude=>self.endereco.latitude,:longitude=>self.endereco.longitude,:destino=>"#{self.nome}")
  end

end
