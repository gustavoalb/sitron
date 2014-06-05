class Administracao::Patio < ActiveRecord::Base
  acts_as_list
  belongs_to :veiculo
  belongs_to :motorista
  belongs_to :empresa
  validates_presence_of :veiculo,:empresa
  validates_uniqueness_of :veiculo_id,:scope=>[:empresa_id,:data_entrada]

  scope :na_data,lambda{|data| where("DATE_PART('DAY',data_entrada) = ? and DATE_PART('MONTH',data_entrada)=? and DATE_PART('YEAR',data_entrada)=?",data.day,data.month,data.year)}
  scope :disponivel, ->{ where(state: "estacionado")}

 state_machine :initial => :estacionado do

    event :ligar do
      transition :estacionado => :saida_proxima
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
