class Administracao::Escola < ActiveRecord::Base
  belongs_to :municipio
  has_one :rota, :as=>:roteavel
end
