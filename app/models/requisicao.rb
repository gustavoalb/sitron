class Requisicao < ActiveRecord::Base
	belongs_to :requisitante,:class_name=>"Administracao::Pessoa"
	belongs_to :posto,:class_name=>"Administracao::Veiculo"
	has_and_belongs_to_many :rotas,:class_name=>"Administracao::Rota"
	validates_presence_of :data_ida,:hora_ida,:motivo
	validates_presence_of :rota_ids, :message=>"Precisa definir ao menos uma rota"
  validates_presence_of :inicio
  #validates_presence_of :fim,:if => Proc.new { |record|!record.agenda?   }
  has_and_belongs_to_many :tipos
  has_and_belongs_to_many :pessoas,:class_name=>"Administracao::Pessoa"
  belongs_to :preferencia,:class_name=>"Tipo"
  has_one :event, dependent: :destroy
  attr_accessor :req_agenda

  scope :aguardando,->{where(:state=>"aguardando").order("created_at ASC ")}
  scope :validas,->{where("inicio > (SELECT CURRENT_TIMESTAMP)")}

  after_create :numero_requisicao
  after_create :evento
  after_validation :setar_distancia

  def rotas_requisicao
    
    ary = []
    
    self.rotas.each do |r|
      ary.push r.destino
    end
      ary.compact.join(',')
  end


def tempo_trajeto
  @tempo = ((self.distancia.to_f*60)/40).round(2) 
  return @tempo+4
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

     def color
      '#2bbce0'
     end
end


state :confirmada do
    def panel
      'success'
  end

     def color
      '#85c744'
     end
end


state :cancelada do
    def panel
      'danger'
    end

       def color
      '#e73c3c'
     end
end


state :agendada do
    def panel
      'default'
  end

     def color
      '#aeafb1'
     end
end


end



def self.processar_fila

    @patio = ""
    @requisicoes = ""
    @patio = Administracao::Patio.na_data(Time.zone.now).all 
    @requisicoes = Requisicao.aguardando.validas.all



    @requisicoes.each do |req|  #faz a varredura nas requisições

       total_passageiros = 1+req.pessoas.count
       if req.tipos.count > 0 #se existe uma preferencia por veiculo
         
          @patio.each do |patio|
         
             if req.tipos.include patio.veiculo.tipo #encontrar o veiculo apropriado pelo tipo
             
             elsif total_passageiros <= patio.veiculo.capacidade_passageiros.to_i #encontrar o veiculo apropriado pela capacidade 
                puts "Foi Aqui que Parou!"
             else
             
             end

           end 

        else
          @patio.each do |patio|
           if total_passageiros <= patio.veiculo.capacidade_passageiros.to_i #encontrar o veiculo apropriado pela capacidade
            #  patio.ligar
            #  req.confirmar
            puts "Foi Aqui"
           end

           end
        
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
 lat_origem = self.requisitante.departamento.endereco.latitude
 lng_origem = self.requisitante.departamento.endereco.longitude
 self.rotas.each do |r|
   lat_destino = r.latitude
   lng_destino = r.longitude
   dist = Geocoder::Calculations.distance_between([lat_origem,lng_origem], [lat_destino,lng_destino])
   @distancia += dist
end
self.distancia = @distancia

if self.fim.nil?
   @tempo = ((self.distancia.to_f*60)/50).round(2)
   self.fim = self.inicio+@tempo.hour 
end

end

def evento
  self.create_event(:name=>self.motivo,:start_at=>self.inicio,:end_at=>self.fim)
end

end
