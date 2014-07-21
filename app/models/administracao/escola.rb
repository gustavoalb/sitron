class Administracao::Escola < ActiveRecord::Base
  has_one :rota, :as=>:roteavel
  belongs_to :municipio,:class_name=>"Cidade"
  has_one :endereco,as: :enderecavel

end
