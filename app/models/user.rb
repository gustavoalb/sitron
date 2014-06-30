# -*- encoding : utf-8 -*-
class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
    self.table_name =  "users"
    has_one :pessoa,class_name: "Administracao::Pessoa"

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  enum role: [:admin, :useget, :coordenador, :req_especial, :aut_especial]
  
  after_initialize :set_default_role, :if => :new_record?

  validates_uniqueness_of :email, :cpf

  has_one :configuracao,:class_name=>"Administracao::Configuracao"

  def set_default_role
    self.role ||= :coordenador
  end

end
