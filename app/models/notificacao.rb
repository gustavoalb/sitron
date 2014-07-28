class Notificacao < ActiveRecord::Base
	belongs_to :origem,:class_name=>"User"
	belongs_to :entidade,class_name: "Administracao::Empresa"
	belongs_to :posto,class_name: "Administracao::Veiculo"
	belongs_to :objeto,:polymorphic=>true
	belongs_to :user
    scope :nao_vista,->{where(:state=>:nao_vista)}
	scope :para_gerentes,->{where("tipo = 0 or tipo = 3")}
	scope :do_usuario, lambda{|user| where(:user_id=>user.id)}

	enum tipo: [:aviso,:cancelamento,:confirmacao,:problema]
	validates_presence_of :texto






	state_machine :initial => :nao_vista do

		event :ver do
			transition :nao_vista => :vista
		end

		event :resolver do
			transition any => :resolvida
		end

		event :descartar do 
			transition any => :descartada
		end

	end
end
