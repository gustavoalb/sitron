class Notificacao < ActiveRecord::Base
	belongs_to :origem,:class_name=>"User"
	belongs_to :entidade,class_name: "Administracao::Empresa"
	belongs_to :posto,class_name: "Administracao::Veiculo"
    scope :nao_vista,->{where(:state=>:nao_vista)}
	enum tipo: [:erro,:aviso,:problema,:motorista,:veiculo,:empresa,:sistema]


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
