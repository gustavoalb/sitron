class Administracao::Cargo < ActiveRecord::Base
  belongs_to :entidade,class_name: "Empresa"
end
