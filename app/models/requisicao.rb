class Requisicao < ActiveRecord::Base
	belongs_to :requisitante,:class_name=>"Administracao::Pessoa"
	belongs_to :posto,:class_name=>"Administracao::Veiculo"
	has_and_belongs_to_many :rotas,:class_name=>"Administracao::Rota"
	validates_presence_of :data_ida,:hora_ida,:motivo
	validates_presence_of :rota_ids, :message=>"Precisa definir ao menos uma rota"

	after_create :numero_requisicao
	after_validation :setar_distancia


	def rotas_requisicao
		ary = []
		self.rotas.each do |r|
			ary.push r.destino
		end
		ary.compact.join(',')
	end













state_machine :initial => :aguardando do

    event :confirmar do
      transition [:aguardando,:agendada] => :confirmada
    end


    event :cancelar do
      transition any => :cancelada
    end

    event :agendar do
      transition any => :agendada
    end

    state :aguardando do
      def panel
        'info'
      end
    end


    state :confirmada do
      def panel
        'success'
      end
    end


    state :cancelada do
      def panel
        'danger'
      end
    end


    state :agendada do
      def panel
        'default'
      end
    end


  end






	private


	def numero_requisicao
		if self.id < 10
			self.numero = "RST000000#{self.id}"
		elsif self.id < 100
			self.numero = "RST00000#{self.id}"
		elsif self.id < 1000 
			self.numero = "RST0000#{self.id}"
		elsif self.id < 10000
			self.numero = "RST000#{self.id}"
		elsif self.id < 100000
			self.numero = "RST00#{self.id}"
		else
			self.numero = "RST#{self.id}"
		end
		self.save
	end




	def setar_distancia
	  @distancia = 0.0
      self.rotas.each do |r|
      	dist = r.roteavel.endereco.distance_to(self.requisitante.departamento.endereco,:km)
        @distancia += dist
      end
      self.distancia = @distancia
	end
end
