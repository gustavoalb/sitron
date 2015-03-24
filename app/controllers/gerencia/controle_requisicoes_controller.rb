# -*- encoding : utf-8 -*-
class Gerencia::ControleRequisicoesController < ApplicationController
  before_action :load_requisicao, only: [:salvar_requisicao, :ordenar_requisicao]

  def index


    @requisicoes = Requisicao.aguardando.urgentes.all


    @requisicoes_proximas_de_sair = Requisicao.proximas_de_sair.all

    @urgentes_aguardando = Requisicao.aguardando.urgentes.accessible_by(current_ability)
    @veiculos = Administracao::Veiculo.all
    @aguardando_hoje = Requisicao.na_data(Time.now).nao_urgentes.aguardando.accessible_by(current_ability).order(:position,:hora)
    @aguardando_amanha = Requisicao.na_data(Date.tomorrow).aguardando.accessible_by(current_ability)
    @proximas_de_sair_amanha = Requisicao.proximas_de_sair.na_data(Date.tomorrow).accessible_by(current_ability)
    @proximas_de_sair_hoje = Requisicao.proximas_de_sair.na_data(Time.now).accessible_by(current_ability)
    @em_servico = Requisicao.em_servico.all
    @finalizadas = Requisicao.finalizadas.page().per(10)
    @postos_especiais = Posto.especiais.na_data(Time.zone.now).order("lote_id, position ASC")
    @postos = Posto.ativo.disponivel.na_data(Time.zone.now).order("position ASC")
    @postos_gerais = @postos +  @postos_especiais

  end

  def ordernar_requisicao
    @requisicao = Requisicao.na_data(Time.now).nao_urgentes.aguardando.accessible_by(current_ability).find(params[:id])
    @requisicao.attributes = requisicao_params
    @requisicao.save
    render :nothing => true
  end


  def definir_posto
  #  authorize! :definir_posto, current_user

  @requisicao = Requisicao.aguardando.find(params[:req_id])

  @posto = Posto.ativos_especiais.find(params[:posto_id])

  @veiculo = @posto.veiculo
  mes = @requisicao.data_ida.month
  ano = @requisicao.data_ida.year
  @confirmada = nil

  if @veiculo.validar_horas_extras(@requisicao.previsao_horas, @requisicao.data_ida.strftime("%U"), mes, ano)
    @requisicao.posto = @posto


    if @requisicao.confirmar
      @posto.ligar
      @confirmada = true
      @mensagem = "O Posto foi definido com sucesso para a Requisição   #{@requisicao.numero}</strong>"
      @notificacao = @requisicao.notificacoes.create(:texto => "Requisição Confirmada: #{@requisicao.numero}", :origem => current_user, :user => @requisicao.requisitante.user, :tipo => 2)
      @notificacoes_recebidas = @requisicao.requisitante.user.notificacoes_recebidas.nao_vista
      @contador = @notificacoes_recebidas.count
    else
      @confirmada = false
      @requisicao.errors.each do |e|
        @mensagem = e
      end
    end

  else
    @confirmada = false
    @mensagem = 'O Posto selecionado Ultrapassará as horas extras permitidas com esta requisição.'
  end

  @requisicoes = Requisicao.aguardando.all
  @postos = Posto.ativo.na_data(Time.zone.now).order("position ASC")

  respond_to do |format|
    format.js
  end


end




def definir_veiculo_final_semana
  @requisicao = Requisicao.aguardando.find(params[:req_id])

  @veiculo = Administracao::Veiculo.find(params[:veiculo_id])

  mes = @requisicao.data_ida.month
  ano = @requisicao.data_ida.year
  @confirmada = nil

  if @veiculo.validar_horas_extras(@requisicao.previsao_horas, @requisicao.data_ida.strftime("%U"), mes, ano)
    @patio = Administracao::Patio.na_data(@requisicao.inicio).first || Administracao::Patio.create(:data_entrada=>@requisicao.inicio)
    @posto = @patio.postos.create!(:codigo=>@veiculo.codigo,:entrada=>@requisicao.inicio,:veiculo_id=>@veiculo.id,:data_entrada=>@requisicao.inicio.to_date,:patio=>@patio,:modalidade_id=>@veiculo.modalidade_id,:empresa_id=>@veiculo.empresa_id,:contrato_id=>@veiculo.contrato_id,:lote=>@veiculo.lote,:turno=>Posto.setar_turno(@requisicao.inicio))

    @requisicao.posto = @posto
    if @requisicao.confirmar
     @posto.ligar
     @confirmada = true
     @mensagem = "O Posto foi definido com sucesso para a Requisição   #{@requisicao.numero}</strong>"
     @notificacao = @requisicao.notificacoes.create(:texto => "Requisição Confirmada: #{@requisicao.numero}", :origem => current_user, :user => @requisicao.requisitante.user, :tipo => 2)
     @notificacoes_recebidas = @requisicao.requisitante.user.notificacoes_recebidas.nao_vista
     @contador = @notificacoes_recebidas.count

   else
    @confirmada = false
    @requisicao.errors.each do |e|
      @mensagem = e
    end
  end

else
  @confirmada = false
  @mensagem = 'O Veículo selecionado Ultrapassará as horas extras permitidas com esta requisição.'
end

@requisicoes = Requisicao.aguardando.all
@postos = Posto.ativo.na_data(Time.zone.now).order("position ASC")

respond_to do |format|
  format.js
end

end



def especial
  @requisicao = Requisicao.new
  @estado = Estado.find_by(:sigla => "AP")
  @cidades = @estado.cidades.collect { |c| [c.nome, c.id] }
  @pessoas = Administracao::Pessoa.pode_ser_passageiro.all
  @postos_comuns = Posto.ativo.na_data(Time.zone.now).order("lote_id, position ASC").collect{|p|["#{p.veiculo.lote.tipo} - #{p.veiculo.placa} - #{p.veiculo.motorista}",p.id]}

  resp = Administracao::Departamento.all.collect { |d| d.responsavel_id }
  @responsaveis = User.do_email("seed.ap.gov.br").collect { |u| ["#{u.pessoa.departamento.sigla} - #{u.pessoa.nome}", u.pessoa.id] }
end

def gerenciar_requisicoes
  @urgentes = Requisicao.aguardando.urgentes.accessible_by(current_ability)
  @postos = Posto.ativo.disponivel.na_data(Time.zone.now).order("position ASC")
  @aguardando_hoje = Requisicao.na_data(Time.now).aguardando.accessible_by(current_ability)
  @aguardando_amanha = Requisicao.na_data(Date.tomorrow).aguardando.accessible_by(current_ability)
  @proximas_de_sair_amanha = Requisicao.proximas_de_sair.na_data(Date.tomorrow).accessible_by(current_ability)
  @proximas_de_sair_hoje = Requisicao.proximas_de_sair.na_data(Time.now).accessible_by(current_ability)
end


def detalhes_requisicao
  @requisicao = Requisicao.find(params[:requisicao_id])
  authorize! :detalhes_requisicao, @requisicao
  @notificacao = Notificacao.find(params[:notificacao_id])
  @postos = Posto.ativo.na_data(Time.zone.now).order("position ASC")
  authorize! :detalhes_requisicao, current_user
end

def salvar_requisicao
  @requisicao = Requisicao.new(requisicao_params)
  @endereco = requisicao_params[:endereco_attributes]

  date_and_time = '%m-%d-%Y %H:%M:%S %Z'
  data = Time.zone.parse("#{requisicao_params[:data_ida].gsub('/', '-')} #{requisicao_params[:hora_ida]}")
  data_retorno = Time.zone.parse("#{requisicao_params[:data_volta].gsub('/', '-')} #{requisicao_params[:hora_volta]}")
    #data = DateTime.strptime("#{requisicao_params[:data_ida].gsub('/','-')} #{requisicao_params[:hora_ida]} Brasilia",date_and_time)
    @requisicao.inicio = data
    @requisicao.fim = data_retorno
    @tipo = @requisicao.tipo_requisicao
    @patio = Administracao::Patio.na_data(Time.zone.now).first || Administracao::Patio.create(:data_entrada=>Time.now)
    @posto = @requisicao.posto


    respond_to do |format|
      if @requisicao.save
        @requisicao.confirmar
        @posto.ligar
        @servico = @requisicao.create_servico(:veiculo_id => @posto.veiculo.id, :user_id => @requisicao.requisitante.user_id, :empresa_id => @posto.veiculo.empresa_id, :contrato_id => @posto.veiculo.contrato_id, :lote => @posto.veiculo.lote, :saida => Time.zone.now, :valor_combustivel_centavos => 2.30, :atendido => true)

        format.html { redirect_to gerencia_controle_requisicoes_index_url, notice: 'A Requisicao foi Criada com Sucesso' }
        format.json { render :show, status: :created, location: @requisicao }
      else
        @estado = Estado.find_by(:sigla => "AP")
        @cidades = @estado.cidades.collect { |c| [c.nome, c.id] }
        @pessoas = Administracao::Pessoa.pode_ser_passageiro.all
        @postos_comuns = Posto.ativo.na_data(Time.zone.now).order("lote_id, position ASC").collect{|p|["#{p.veiculo.lote.tipo} - #{p.veiculo.placa} - #{p.veiculo.motorista}",p.id]}

        @responsaveis = User.do_email("seed.ap.gov.br").collect { |u| [u.pessoa.nome, u.pessoa.id] }
        format.html { render :especial, alert: 'A Requisicao não foi criada!' }
        format.html { redirect_to gerencia_controle_requisicoes_index_url, alert: 'A Requisição não foi criada' }

        # format.json { render json: @requisicao.errors, status: :unprocessable_entity }
      end
    end

  end


  def cancelar_requisicao
    @requisicao = Requisicao.find(params[:requisicao])

    @requisicao.motivo_cancelamento = params[:motivo]
    @requisicao.cancelar
    @notificacao = @requisicao.notificacoes.create(:texto => "Requisição Cancelada: #{@requisicao.numero}", :origem => current_user, :user => @requisicao.requisitante.user, :tipo => 1)
    @notificacoes_recebidas = @requisicao.requisitante.user.notificacoes_recebidas.nao_vista
    @contador = @notificacoes_recebidas.count

    respond_to do |format|
      format.js
    end

    #redirect_to gerencia_controle_requisicoes_index_url, alert: "A requisição #{@requisicao.id} de #{@requisicao.requisitante.nome} foi cancelada"
  end


  def cancelar_confirmada

    @requisicao = Requisicao.find(params[:requisicao])
    authorize! :cancelar_confirmada, @requisicao
    @posto = @requisicao.posto
    @requisicao.motivo_cancelamento = params[:motivo]

    if @requisicao.tipo_requisicao == 'especial'
      @requisicao.cancelar
      @posto.estacionar
      @posto.sair_do_patio
    else
      @requisicao.cancelar
      @posto.estacionar
    end

    @notificacao = @requisicao.notificacoes.create(:texto => "Requisição Cancelada: #{@requisicao.numero}", :origem => current_user, :user => @requisicao.requisitante.user, :tipo => 1)
    @notificacoes_recebidas = @requisicao.requisitante.user.notificacoes_recebidas.nao_vista
    @contador = @notificacoes_recebidas.count


    respond_to do |format|
      format.js
    end

  end

  def cancelar_posto
    @requisicao = Requisicao.find(params[:requisicao_id])
    @posto = @requisicao.posto
    @posto.estacionar
    @requisicao.posto_id = nil
    @requisicao.aguardar

    redirect_to gerencia_controle_requisicoes_index_path,:alert=>"O Posto para a Requisição n.º #{@requisicao.numero} foi desfeito, defina outro posto ou cancele a requsição"
  end


  def saida_servico
    @requisicao = Requisicao.confirmada.find(params[:requisicao_id])
    @mensagem = nil


    if @requisicao

      if (params.has_key?(:numero_da_portaria)) and !params[:numero_da_portaria].nil?
        @requisicao.numero_da_portaria = params[:numero_da_portaria]
      end

      @patio = Administracao::Patio.na_data(Time.zone.now).first
      @posto = @requisicao.posto
      @postos = @patio.postos.ativo.na_data(Time.zone.now).order("position ASC")

      if @posto and @posto.saida_proxima?
        @servico = @requisicao.create_servico(:veiculo_id => @posto.veiculo.id, :user_id => @requisicao.requisitante.user_id, :empresa_id => @posto.veiculo.empresa_id, :contrato_id => @posto.veiculo.contrato_id, :lote => @posto.veiculo.lote, :saida => Time.zone.now, :valor_combustivel_centavos => 2.30)
        @posto.sair
        @requisicao.data_ida = Time.zone.now
        @requisicao.hora_ida = Time.zone.now
        @requisicao.ativar
        @requisicoes_proximas_de_sair = Requisicao.proximas_de_sair.all
      else
        @mensagem = "A Requisição já foi confirmada!"
      end
    else
      @mensagem = "Nenhuma requisição encontrada com este código ou a requisição já foi finalizada!"
    end


    respond_to do |format|
      format.js
    end


  end


  def chegada_servico

    @requisicao = Requisicao.em_servico.find(params[:requisicao_id])
    @mensagem = nil


    if @requisicao
      @patio = Administracao::Patio.na_data(Time.zone.now).first
      @posto = @requisicao.posto
      veiculo = @posto.veiculo
      @postos = @patio.postos.ativo.na_data(Time.zone.now).order("position ASC")

      if @posto and @posto.em_transito?
        @servico = Administracao::Servico.where(:requisicao_id => @requisicao.id, :veiculo_id => @posto.veiculo.id, :user_id => @requisicao.requisitante.user_id).first
        @servico.chegada = Time.zone.now
        if @servico.save
         @posto.estacionar
         @requisicao.data_volta = Time.zone.now
         @requisicao.hora_volta = Time.zone.now
         @requisicao.finalizar
         @servico.atendido = true
         @em_servico = Requisicao.em_servico.all
         
       else
        @mensagem = "Erro ao Finalizar o Serviço!"
      end

    else
      @mensagem = "A Requisição aparentemente já encontra-se finalizada!"
    end

  else
    @mensagem = "Este não parece ser um codigo de barras válido ou a Requisição já foi finalizada!"
  end

  respond_to do |format|
    format.js
  end

end

private



def requisicao_params
  params.require(:requisicao).permit(:position, :numero, :pernoite, :descricao, :numero_passageiros, :requisitante_id, :data_ida, :hora_ida, :periodo, :tipo_requisicao, :periodo_longo, :inicio, :fim, :posto_id, :preferencia_id, :data_volta, :hora_volta, :motivo_id, :tipo_carga, :rota_ids => [], :pessoa_ids => [], endereco_attributes: [:logradouro, :numero, :complemento, :estado_id, :cidade_id, :bairro_id, :cep, :endereco, :latitude, :longitude, :descricao])
end

def load_requisicao
  @requisicao = Requisicao.new(requisicao_params)
  @estado = Estado.find_by(:sigla => "AP")
end

end
