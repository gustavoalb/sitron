class Administracao::Escola < ActiveRecord::Base
  belongs_to :municipio,:class_name=>"Cidade"
  has_one :endereco,as: :enderecavel
end
