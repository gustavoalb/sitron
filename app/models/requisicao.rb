# -*- encoding : utf-8 -*-
require 'barby'
require 'barby/barcode/code_128'
require 'barby/outputter/png_outputter'
class Requisicao < ActiveRecord::Base

  audited on: [:update, :destroy]

#  include RankedModel
#  ranks :position
  acts_as_list scope: [:tipo_requisicao,:data_ida]

  mount_uploader :qrcode, ArtefatoUploader
  mount_uploader :codigo_de_barras, ArtefatoUploader


  belongs_to :requisitante, :class_name => "Administracao::Pessoa"
  belongs_to :posto
  belongs_to :motivo, :class_name => "Administracao::Motivo"
  has_and_belongs_to_many :rotas, :class_name => "Administracao::Rota"
  validates_presence_of :data_ida, :hora_ida, :motivo_id
  validates_presence_of :rota_ids, :message => "Precisa definir ao menos uma rota", if: Proc.new { |req| req.endereco.nil? }
  validates_presence_of :descricao, :message => "Precisa informar com detalhes o caso", if: Proc.new { |req| req.motivo and req.motivo.necessita_descricao? }
  #validates_presence_of :tipo_carga, :message => "Precisa informar o tipo de carga", if: Proc.new { |req| req.motivo and req.motivo.carga? }
  validates_presence_of :inicio
  validates_inclusion_of :pernoite, :in => [true], :message => "Para pernoite em Macapá, é necessário fazer uma requisição para cada dia.", :if => Proc.new { |req| req.tipo_requisicao=='agendada' }
  validates_presence_of :descricao, if: Proc.new { |req| req.tipo_requisicao=='urgente' or req.tipo_requisicao == 'fim_de_semana' }
  validates_inclusion_of :numero_passageiros, in: 1..15, :message => "Número precisa ser informado!", if: Proc.new { |req| req.pessoa_ids.count>0 }
  validates_length_of :descricao, :maximum => 160, :message => "A Descrição não pode ultrapassar 160 caracteres"
  validates_presence_of :requisitante_id, :message => "Precisa definir o Responsável pela requisição"
  #validate :hora
  validates_presence_of :fim, :if => Proc.new { |record| !record.agenda? }
  has_and_belongs_to_many :tipos
  has_and_belongs_to_many :pessoas, :class_name => "Administracao::Pessoa"
  belongs_to :preferencia, :class_name => "Tipo"
  has_one :servico, :class_name => "Administracao::Servico", dependent: :destroy
  has_one :event, dependent: :destroy
  has_one :provisao, :class_name => "Administracao::Provisao", :dependent => :destroy
  has_many :avaliacoes
  has_one :endereco, :as => :enderecavel, :dependent => :destroy

  has_many :mensagens, :as => :objeto, dependent: :destroy
  has_many :notificacoes, :as => :objeto, dependent: :destroy

  accepts_nested_attributes_for :endereco, limit: 1, :reject_if => proc { |attributes| attributes['endereco'].blank? and attributes['endereco'].blank? }, :allow_destroy => true

  before_validation :on => :create

  def atualizar_state

    self.send(:initialize_state_machines, :dynamic => :force)

  end

  attr_accessor :req_agenda

  scope :aguardando, -> { where(:state => "aguardando").order("created_at ASC ") }
  scope :confirmada, -> { where(:state => "confirmada").order("created_at ASC ") }
  scope :finalizadas, -> { where(:state => "finalizada").order("created_at ASC ") }
  scope :canceladas, -> { where(:state => "cancelada").order("created_at ASC ") }
  scope :normal_agendada, -> { where("tipo_requisicao in (0,2)") }
  scope :finais_de_semana,->{ where("tipo_requisicao = ?",4)}
  scope :urgentes, -> { where("tipo_requisicao = 1") }
  scope :nao_urgentes, -> { where("tipo_requisicao <>1") }
  scope :proximas_de_sair, -> { joins(:posto).where("requisicoes.state=? and postos.state = ?", 'confirmada', 'saida_proxima').order("created_at ASC ") }
  scope :em_servico, -> { joins(:posto).where("requisicoes.state=? and postos.state = ?", 'ativa', 'em_transito').order("created_at ASC ") }


  scope :validas, -> { where("inicio > (SELECT CURRENT_TIMESTAMP)") }
  scope :na_data, lambda { |data| where("DATE_PART('DAY',data_ida) = ? and DATE_PART('MONTH',data_ida)=? and DATE_PART('YEAR',data_ida)=?", data.day, data.month, data.year) }
  scope :na_data_exata, lambda { |data| where("DATE_PART('DAY',inicio) = ? and DATE_PART('MONTH',inicio)=? and DATE_PART('YEAR',inicio)=?", data.day, data.month, data.year) }
  scope :no_periodo_data ,lambda{|inicio,fim| where("inicio >= to_date(?,'YYYY-MM-DD') AND inicio <= to_date(?,'YYYY-MM-DD')",inicio,fim)}
  scope :na_hora, lambda { where("(inicio BETWEEN ? and ?)", Time.now, Time.at(20.minutes.since)) } 
  scope :na_hora2, lambda {|t1,t2| where("(inicio BETWEEN ? and ?)", t1, t2) }
  scope :na_hora_exata, lambda {|hora| where(:hora=>hora) }
  scope :do_tipo,lambda{|tipo|where(:tipo_requisicao=>tipo)}
  scope :do_posto,lambda{|posto|joins(:posto).where("(requisicoes.state=? or requisicoes.state=?) and postos.id=?", 'confirmada', 'ativa',posto.id) }
  scope :no_periodo,lambda{|inicio,fim|where("inicio >= ? and inicio < ?",inicio,fim)}
  after_create :numero_requisicao, :criar_notificacao
  after_create :evento, :gerar_code,:setar_posicao
  #after_validation :setar_distancia
  enum tipo_requisicao: [:normal, :urgente, :agendada, :especial,:fim_de_semana]
  enum tipo_carga: ["Mobiliário Escolar", "Livros Didáticos", "ETC"]

  def codigo_requisicao
    code = self.id.to_s
    case code.chars.count
      when 1
        code_req = "0000#{code}"
      when 2
        code_req = "000#{code}"
      when 3
        code_req = "00#{code}"
      when 4
        code_req = "0#{code}"
      else
        code_req = "#{code}"
    end
    return code_req
  end


  def periodo_da_requisicao
    "de #{self.inicio.in_time_zone("Brasilia").strftime("%H:%M")} até #{self.fim.in_time_zone("Brasilia").strftime("%H:%M")}"
  end


  def periodo_completo_da_requisicao
    "de #{self.data_ida.to_s_br} ás #{self.inicio.in_time_zone("Brasilia").strftime("%H:%M")} até #{self.data_volta.to_s_br} ás #{self.fim.in_time_zone("Brasilia").strftime("%H:%M")}"
  end


  def servico_executado
    ary = []
    ary.push self.motivo.nome
    if self.tipo_carga
      ary.push self.tipo_carga
    end
    if self.descricao
      ary.push self.descricao
    end
    ary.compact.join(', ')
  end


  def validar_hora
    if self.data_ida==Date.today and self.hora_ida < Time.now+1.hour
      errors.add(:hora_ida, "Tempo mínimo entre o requerimento e a hora de partida é de 1 hora")
    end
  end


  def rotas_requisicao

    ary = []
    if self.rotas.count > 0
      self.rotas.each do |r|
        ary.push r.destino
      end
    else
      if self.endereco
        ary.push self.endereco.descricao
        ary.push self.endereco.endereco
      end
    end
    ary.compact.join(', ')
  end


    def rotas_municipio

    ary = []
    if self.rotas.count > 0
      self.rotas.each do |r|
        ary.push "#{r.destino} - #{r.roteavel.endereco.cidade.nome}" if r.roteavel.endereco.cidade
      end
    else
      if self.endereco
        ary.push "#{self.endereco.descricao} - #{self.endereco.cidade.nome}" if self.endereco.cidade
      end
    end
    ary.compact.join(', ')
  end


  def codigo_aleatorio

    code = rand(9999)

    case code.to_s.chars.count
      when 1
        code_a = "000#{code}"
      when 2
        code_a = "00#{code}"
      when 3
        code_a = "0#{code}"
      else
        code_a = "#{code}"
    end

    return code_a
  end


  def servidores_nome

    ary = []

    self.pessoas.each do |p|
      ary.push p.nome
    end
    ary.compact.join(', ')
  end


  def tempo_trajeto
    @tempo = ((self.distancia.to_f*60)/40).round(2)
    return @tempo+4
  end


  def generate_codigo_de_barras
    code = "#{self.codigo_requisicao}#{self.requisitante.codigo_pessoa}#{self.codigo_aleatorio}"
    dv = code.generate_check_digit
    return "#{code}#{dv}"
  end



def lote_veiculo
 self.posto.veiculo.lote.nome
end

def inicio_br
 self.inicio.to_s_br
end

def departamento_nome
  if self.requisitante
  self.requisitante.departamento.nome
else
  'Nada Informado'
end
end

def departamento_sigla
  if self.requisitante
 self.requisitante.departamento.sigla
 else
  'Nada Informado'
end
end


def requisitante_nome
  if self.requisitante
  self.requisitante.nome
  else
  'Nada Informado'
end
end


  def confirmar_requisicao(posto)
    self.posto = posto
    self.confirmar
    posto.ligar

    user = User.do_email("administrador").first
    notificacao = self.notificacoes.create(:texto => "Reqisição confirmada: #{self.numero}", :origem => user, :user => self.requisitante.user, :tipo => 2)
    @notificacoes_recebidas = self.requisitante.user.notificacoes_recebidas.nao_vista
    contador = @notificacoes_recebidas.count
    mess = ''
    mess+="$('#contador_notificacao').html(\"<span class='badge'>#{contador}</span>\");"
    mess+="$('#header_notificacoes').html(\"<span>Você tem #{contador} #{'nova'.pluralize(contador)} #{'mensagem'.pluralize(contador)}</span>\");"
    mess+="$.ionSound.play(\"car_horn\");"
    mess+="$.pnotify({title: 'Aviso',text: 'Sua Requisição #{self.numero} foi confirmada, e o posto já encontra-se aguardando',type: 'success',history: false});"
    PrivatePub.publish_to "/#{self.requisitante.user.id}", :chat_message => mess
  end


  def cancelar_requisicao(motivo)
    self.motivo_cancelamento = motivo
    self.cancelar

    user = User.do_email("administrador").first
    notificacao = self.notificacoes.create(:texto => "Reqisição cancelada: #{self.numero}", :origem => user, :user => self.requisitante.user, :tipo => 1)
    @notificacoes_recebidas = self.requisitante.user.notificacoes_recebidas.nao_vista
    contador = @notificacoes_recebidas.count
    mess = ''
    mess+="$('#contador_notificacao').html(\"<span class='badge'>#{contador}</span>\");"
    mess+="$('#header_notificacoes').html(\"<span>Você tem #{contador} #{'nova'.pluralize(contador)} #{'mensagem'.pluralize(contador)}</span>\");"
    mess+="$.ionSound.play(\"computer_error\");"
    mess+="$.pnotify({title: 'Cancelamento',text: 'Sua Requisição #{self.numero} foi cancelada, e o motivo foi: #{motivo}',type: 'error',history: false,sticker: false});"
    PrivatePub.publish_to "/#{self.requisitante.user.id}", :chat_message => mess
  end


  def horas_extras
    saida = self.servico.saida
    chegada = self.servico.chegada
    ary_horas = [12, 13, 18, 19, 20, 21, 22, 23, 00, 1, 2, 3, 4, 5, 6, 7]

    horas_extras = 0

    (saida.to_datetime.to_i .. chegada.to_datetime.to_i).step(1.hour) do |date|
      if ary_horas.include? Time.at(date).hour
        horas_extras += 1
      end
    end

    return horas_extras

  end


  def horas_normais
    segundos = 0.0
    minutos = 0.0
    saida = self.servico.saida
    chegada = self.servico.chegada

    (saida.to_datetime.to_i .. chegada.to_datetime.to_i).step(1.seconds) do |date|
      segundos += 1
    end

    minutos = segundos / 60

    return minutos

  end


  def previsao_horas
    segundos = 0.0
    minutos = 0.0
    saida = self.inicio
    chegada = self.fim

    (saida.to_datetime.to_i .. chegada.to_datetime.to_i).step(1.seconds) do |date|
      segundos += 1
    end

    minutos = segundos / 60
    horas = minutos / 60
    return horas
  end


  state_machine :initial => :aguardando do

    after_transition :confirmada => :finalizada do |requisicao, transition|
      posto = requisicao.posto
      veiculo = posto.veiculo
      servico = requisicao.servico
    end

    after_transition any => :agendada do |requisicao, transition|

      data = Time.zone.parse("#{requisicao.data_ida} #{requisicao.hora_ida.in_time_zone('Brasilia')}")

      Administracao::Lote.do_tipo(requisicao.motivo.tipo.nome).all.each do |l|
        l.veiculos.each do |v|
          if !v.aprovisionado?(requisicao.data_ida)
            requisicao.create_provisao(veiculo: v, data_aprovisionamento: data)
            break
          end
        end
      end
    end


    event :confirmar do
      transition [:aguardando, :agendada] => :confirmada
    end


    event :cancelar do
      transition any => :cancelada
    end

    event :agendar do
      transition any => :agendada
    end

    event :ativar do
      transition :confirmada => :ativa
    end


    event :finalizar do
      transition any => :finalizada
    end

    event :aguardar do
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


    state :ativa do
         def panel
           'default'
         end

         def color
           '#aeafb1'
         end
       end

    state :finalizada do
      def panel
        'default'
      end

      def color
        '#aeafb1'
      end
    end


  end


  def gerar_code
    codigo = self.generate_codigo_de_barras

    qr = RQRCode::QRCode.new(codigo, :size => 4, :level => :h)
    png = qr.to_img
    caminho=%(#{Rails.root}/tmp/#{self.id}.png)
    png.resize(900, 900).save(caminho)
    file = File.open(caminho)
    self.qrcode = file
    File.delete(caminho)


    codigo = self.generate_codigo_de_barras


    barcode = Barby::Code128B.new(codigo)


    caminho=%(#{Rails.root}/tmp)

    File.open("#{caminho}/#{codigo.upcase}.png", 'w') { |f| f.write barcode.to_png(margin: 0) }
    file = File.open("#{caminho}/#{codigo.upcase}.png")
    self.codigo_de_barras = file
    File.delete(file)

    self.codigo = codigo
    self.hora = self.inicio.hour
    self.save
  end

  validate do
    contador = 9
    n = 0
    if self.pessoa_ids.count < self.numero_passageiros.to_i
      self.errors.add(:pessoa_ids, "Número de passageiros inferior ao informado (#{self.pessoa_ids.count} para #{self.numero_passageiros})")
      self.pessoa_ids = []
    elsif self.pessoa_ids.count > self.numero_passageiros.to_i
      self.pessoa_ids = []
      self.errors.add(:pessoa_ids, "Número de passageiros superior ao informado  (#{self.pessoa_ids.count} para #{self.numero_passageiros})")
    end

    @requisicoes = Requisicao.na_data(self.inicio)
    @requisicoes.each do |r|
      if r.inicio.hour == self.inicio.hour
        n+=1
      end
    end

    if n and n >= contador
      self.errors.add(:hora_ida,"Existem muitas para esse horário, por favor, defina outro horário!")
    end



  end

  private



  def setar_posicao
   requisicoes = Requisicao.na_data(self.data_ida).do_tipo(self.tipo_requisicao)

   if requisicoes and requisicoes.count > 1
     self.move_to_bottom
   else
     self.move_to_top
   end
  end



  def numero_requisicao

    @n = nil

    case self.tipo_requisicao
      when "normal"
        @n="N"
      when "urgente"
        @n="U"
      when "agendada"
        @n="A"
      when "especial"
        @n="E"
    end

    if self.id < 10
      self.numero = "RST#{@n}000000#{self.id}"
    elsif self.id < 100
      self.numero = "RST#{@n}00000#{self.id}"
    elsif self.id < 1000
      self.numero = "RST#{@n}0000#{self.id}"
    elsif self.id < 10000
      self.numero = "RST#{@n}000#{self.id}"
    elsif self.id < 100000
      self.numero = "RST#{@n}00#{self.id}"
    else
      self.numero = "RST#{@n}#{self.id}"
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
      dist = Geocoder::Calculations.distance_between([lat_origem, lng_origem], [lat_destino, lng_destino])
      @distancia += dist
    end
    self.distancia = @distancia

    if self.fim.nil?
      @tempo = ((self.distancia.to_f*60)/50).round(2)
      self.fim = self.inicio+@tempo.hour
    end

  end

  def evento
    self.create_event(:name => self.motivo, :start_at => self.inicio, :end_at => self.fim)
  end


  def criar_notificacao
    if self.tipo_requisicao=="urgente"
      self.notificacoes.create(texto: "Requisição de Transporte Urgente", :tipo => 0)
    end
  end

end
