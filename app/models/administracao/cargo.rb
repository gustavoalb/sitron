# -*- encoding : utf-8 -*-
class Administracao::Cargo < ActiveRecord::Base
  belongs_to :entidade,class_name: "Empresa"
end
