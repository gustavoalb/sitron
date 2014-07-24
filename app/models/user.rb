# -*- encoding : utf-8 -*-
class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
    self.table_name =  "users"
    has_one :pessoa,class_name: "Administracao::Pessoa"#,:dependent=>:destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  enum role: [:administrador, :useget, :coordenador]
  
  
  after_initialize :set_default_role, :if => :new_record?

  validates_uniqueness_of :email

  has_one :configuracao,:class_name=>"Administracao::Configuracao"

  accepts_nested_attributes_for :pessoa

  def set_default_role  
    self.role ||= :coordenador
  end

end
