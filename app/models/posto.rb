class Posto < ActiveRecord::Base
  belongs_to :veiculo,:class_name=>"Administracao::Veiculo"
  belongs_to :patio,:class_name=>"Administracao::Patio"
  belongs_to :contrato,:class_name=>"Administracao::Contrato"
  belongs_to :empresa,:class_name=>"Administracao::Empresa"
  belongs_to :lote,:class_name=>"Administracao::Lote"
  acts_as_list scope: [:lote]
  validates_presence_of :codigo

  #enum lote:  [:"Lote 01",:"Lote 02",:"Lote 03",:"Lote 04",:"Lote 05",:"Lote 06",:"Lote 07",:"Lote 08",:"Lote ùnico"]

  scope :na_data,lambda{|data| where("DATE_PART('DAY',entrada) = ? and DATE_PART('MONTH',entrada)=? and DATE_PART('YEAR',entrada)=?",data.day,data.month,data.year)}
  
  scope :disponivel, ->{ where(state: "estacionado")}
  scope :em_transito, ->{ where(state: "em_transito")}
  scope :proximo_de_sair,->{where(state: "saida_proxima")}

 state_machine :initial => :estacionado do

    event :ligar do
      transition :estacionado => :saida_proxima
    end

    event :estacionar do 
      transition [:em_transito,:com_problema] => :estacionado
    end



    event :sair do 
      transition any => :em_transito
    end

     event :quebrar do 
     	transition any => :com_problema
     end

     event :consertar do 
     	transition :com_problema => :estacionado
     end

     event :agendar do 
     	transition :estacionado => :agendado
     end



    state :estacionado do
      def status
        'Aguardando'
      end
    end

    state :agendado do
      def status
        'Agendado'
      end
    end



    state :saida_proxima do 
    	def status 
    	  'Próximo de Sair'
    	end
    end

    state :em_transito do 
    	def status 
    	  'Em Trânsito'
    	end
    end

    state :com_problema do 
    	def status 
    	  'Com Problemas'
    	end
    end

  end

  
end