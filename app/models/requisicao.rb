class Requisicao < ActiveRecord::Base
	belongs_to :requisitante,:class_name=>"Administracao::Pessoa"
	belongs_to :posto
  belongs_to :motivo,:class_name=>"Administracao::Motivo"
  has_and_belongs_to_many :rotas,:class_name=>"Administracao::Rota"
  validates_presence_of :data_ida,:hora_ida,:motivo_id
  validates_presence_of :rota_ids, :message=>"Precisa definir ao menos uma rota"
  validates_presence_of :inicio
  validates_presence_of :descricao,if: Proc.new { |req| req.tipo_requisicao=='urgente' }
  validates_inclusion_of :numero_passageiros, in: 1..15,:message=>"Número excede ao máximo permitido!"
  validates_length_of :descricao, :maximum=>160, :message=>"A Descrição não pode ultrapassar 160 caracteres"
  #validate :hora
  #validates_presence_of :fim,:if => Proc.new { |record|!record.agenda?   }
  has_and_belongs_to_many :tipos
  has_and_belongs_to_many :pessoas,:class_name=>"Administracao::Pessoa"
  belongs_to :preferencia,:class_name=>"Tipo"
  has_one :event, dependent: :destroy
  has_many :mensagens,:as=>:objeto
  has_many :notificacoes,:as=>:objeto

  attr_accessor :req_agenda

  scope :aguardando,->{where(:state=>"aguardando").order("created_at ASC ")}
  scope :confirmada,->{where(:state=>"confirmada").order("created_at ASC ")}
  
  scope :validas,->{where("inicio > (SELECT CURRENT_TIMESTAMP)")}

  after_create :numero_requisicao,:enviar_mensagem,:criar_notificacao
  after_create :evento
  #after_validation :setar_distancia
  enum tipo_requisicao: [:normal,:urgente,:agendada]
  

  def hora
    if self.data_ida==Date.today and self.hora_ida < Time.now+1.hour
      errors.add(:hora_ida,"Tempo mínimo entre o requerimento e a hora de partida é de 1 hora")
    end
  end


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

  after_transition :confirmada => :saindo do |r, transition|
     r.data_ida = Time.zone.now.to_date
     r.hora_ida = Time.zone.now
   end

   after_transition :em_curso => :finalizada do |r, transition|
    r.data_volta = Time.zone.now.to_date
    r.hora_volta = Time.zone.now
  end

  event :confirmar do
    transition [:aguardando,:agendada] => :confirmada
  end

  event :sair do
    transition any => :saindo
  end

  event :cancelar do
    transition any => :cancelada
  end

  event :agendar do
    transition any => :agendada
  end

  event :finalizar do 
    transition :saindo => :finalizada
  end

  event :aguardar  do
   transition any => :aguardando
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

 requisitante = self.requisitante

 lat_origem = requisitante.departamento.endereco.latitude
 lng_origem = requisitante.departamento.endereco.longitude
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

def enviar_mensagem
  self.mensagens.create(texto: "Nova requisição de Serviço",tipo_usuario: "administrador")
end

def criar_notificacao
  self.notificacoes.create(texto: "Nova requisição de Serviço de Transporte")
end

end
