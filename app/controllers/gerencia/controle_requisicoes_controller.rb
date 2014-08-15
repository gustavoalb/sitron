# -*- encoding : utf-8 -*-
class Gerencia::ControleRequisicoesController < ApplicationController
  before_action :load_requisicao, only: :salvar_requisicao
  def index

    authorize! :index,current_user
    @requisicoes = Requisicao.aguardando.urgentes.all
    @postos = Posto.ativo.disponivel.na_data(Time.zone.now).order("position ASC")
    @requisicoes_proximas_de_sair = Requisicao.proximas_de_sair.all

    @urgentes_aguardando = Requisicao.aguardando.urgentes.accessible_by(current_ability)
    @postos = Posto.ativo.disponivel.na_data(Time.zone.now).order("position ASC")
    @aguardando_hoje = Requisicao.na_data(Time.now).nao_urgentes.aguardando.accessible_by(current_ability)
    @aguardando_amanha = Requisicao.na_data(Date.tomorrow).aguardando.accessible_by(current_ability)
    @proximas_de_sair_amanha = Requisicao.proximas_de_sair.na_data(Date.tomorrow).accessible_by(current_ability)
    @proximas_de_sair_hoje = Requisicao.proximas_de_sair.na_data(Time.now).accessible_by(current_ability)




  end

  def ordernar_requisicao
     @aguardando_hoje = Requisicao.na_data(Time.now).nao_urgentes.aguardando.accessible_by(current_ability)
     @aguardando_hoje.each do |req|
        req.position = params[:requisicao].index(req.id.to_s) + 1
        req.save!
     end
     render :nothing => true
  end


  def definir_posto

    @requisicao = Requisicao.aguardando.find(params[:req_id])
    authorize! :definir_posto,@requisicao
    @posto = Posto.ativo.find(params[:posto_id])
    @veiculo = @posto.veiculo
    mes = @requisicao.data_ida.month
    ano = @requisicao.data_ida.year
    @confirmada = nil

    if @veiculo.validar_horas_extras(@requisicao.previsao_horas,@requisicao.data_ida.strftime("%U"),mes,ano)
     @requisicao.posto = @posto
     @requisicao.confirmar
     @posto.ligar
     @confirmada = true
     @mensagem = "O Posto foi definido com sucesso para a Requisição   #{@requisicao.numero}</strong>"
     @notificacao = @requisicao.notificacoes.create(:texto=>"Requisição Confirmada: #{@requisicao.numero}",:origem=>current_user,:user=>@requisicao.requisitante.user,:tipo=>2)
     @notificacoes_recebidas = @requisicao.requisitante.user.notificacoes_recebidas.nao_vista
     @contador = @notificacoes_recebidas.count

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

def especial
  @requisicao = Requisicao.new
  @estado = Estado.find_by(:sigla=>"AP")
  @cidades = @estado.cidades.collect{|c|[c.nome,c.id]}
  @pessoas = Administracao::Pessoa.pode_ser_passageiro.accessible_by(current_ability).all
  @postos_comuns = Posto.ativo.na_data(Time.zone.now).order("lote_id, position ASC")
  @ary = @postos_comuns.collect{|c|c.veiculo_id}
  @veiculos = Administracao::Veiculo.nao_entraram(@ary).all
  resp = Administracao::Departamento.all.collect {|d|d.responsavel_id}
  @responsaveis = User.do_email("seed.ap.gov.br").collect{|u|[u.pessoa.nome,u.pessoa.id]} 


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
  authorize! :detalhes_requisicao,@requisicao
  @notificacao = Notificacao.find(params[:notificacao_id])
  @postos = Posto.ativo.na_data(Time.zone.now).order("position ASC")

  authorize! :detalhes_requisicao,current_user
end

def salvar_requisicao


  @requisicao = Requisicao.new(requisicao_params)
  @endereco = requisicao_params[:endereco_attributes]

  date_and_time = '%m-%d-%Y %H:%M:%S %Z'
  data = Time.zone.parse("#{requisicao_params[:data_ida].gsub('/','-')} #{requisicao_params[:hora_ida]}")
  data_retorno = Time.zone.parse("#{requisicao_params[:data_volta].gsub('/','-')} #{requisicao_params[:hora_volta]}")
    #data = DateTime.strptime("#{requisicao_params[:data_ida].gsub('/','-')} #{requisicao_params[:hora_ida]} Brasilia",date_and_time)
    @requisicao.inicio = data
    @requisicao.fim = data_retorno
    @tipo = @requisicao.tipo_requisicao
    if @requisicao.posto_id
      @veiculo = Administracao::Veiculo.find(@requisicao.posto_id)
      codigo = @veiculo.codigo
      @patio = Administracao::Patio.na_data(Time.zone.now).first || Administracao::Patio.create(:data_entrada=>Time.now)
      @posto = @patio.postos.find_by(:codigo=>codigo,:turno=>Posto.setar_turno(Time.zone.now))
      if @posto
        @posto.estacionar
        @requisicao.posto = @posto
      else
        @posto = @patio.postos.create!(:codigo=>codigo,:entrada=>Time.zone.now,:veiculo_id=>@veiculo.id,:data_entrada=>Time.zone.now.to_date,:patio=>@patio,:modalidade_id=>@veiculo.modalidade_id,:empresa_id=>@veiculo.empresa_id,:contrato_id=>@veiculo.contrato_id,:lote=>@veiculo.lote,:turno=>Posto.setar_turno(Time.zone.now))
        @requisicao.posto = @posto
      end
    end


    respond_to do |format|
      if @requisicao.save
       @requisicao.confirmar
       @posto.ligar
       @servico = @requisicao.create_servico(:veiculo_id=>@posto.veiculo.id, :user_id=>@requisicao.requisitante.user_id, :empresa_id=>@posto.veiculo.empresa_id, :contrato_id=>@posto.veiculo.contrato_id,:lote=>@posto.veiculo.lote, :saida=> Time.zone.now,:valor_combustivel_centavos=>2.30,:atendido=>true)

       format.html { redirect_to gerencia_controle_requisicoes_index_url, notice: 'A Requisicao foi Criada com Sucesso' }
       format.json { render :show, status: :created, location: @requisicao }
     else
      @estado = Estado.find_by(:sigla=>"AP")
      @cidades = @estado.cidades.collect{|c|[c.nome,c.id]}
      @pessoas = Administracao::Pessoa.pode_ser_passageiro.accessible_by(current_ability).all
      @postos_comuns = Posto.ativo.na_data(Time.zone.now).order("lote_id, position ASC")
      @ary = @postos_comuns.collect{|c|c.veiculo_id}
      @veiculos = Administracao::Veiculo.nao_entraram(@ary).all
      @responsaveis = Administracao::Departamento.all.collect{|d|[d.responsavel.nome,d.responsavel_id]} 
      format.html { render :especial, alert: 'A Requisicao não foi criada!' }
      format.html { redirect_to gerencia_controle_requisicoes_index_url, alert: 'A Requisição não foi criada' }

       # format.json { render json: @requisicao.errors, status: :unprocessable_entity }
     end
   end

 end


 def cancelar_requisicao

  @requisicao = Requisicao.find(params[:requisicao])
  authorize! :cancelar_requisicao,@requisicao

  @requisicao.motivo_cancelamento = params[:motivo]
  @requisicao.cancelar
  @notificacao = @requisicao.notificacoes.create(:texto=>"Requisição Cancelada: #{@requisicao.numero}",:origem=>current_user,:user=>@requisicao.requisitante.user,:tipo=>1)
  @notificacoes_recebidas = @requisicao.requisitante.user.notificacoes_recebidas.nao_vista
  @contador = @notificacoes_recebidas.count
  authorize! :cancelar_requisicao,current_user
  respond_to do |format|
    format.js 
  end

  #redirect_to gerencia_controle_requisicoes_index_url, alert: "A requisição #{@requisicao.id} de #{@requisicao.requisitante.nome} foi cancelada"
end



def cancelar_confirmada

  @requisicao = Requisicao.find(params[:requisicao])
  authorize! :cancelar_confirmada,@requisicao
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
  
  @notificacao = @requisicao.notificacoes.create(:texto=>"Requisição Cancelada: #{@requisicao.numero}",:origem=>current_user,:user=>@requisicao.requisitante.user,:tipo=>1)
  @notificacoes_recebidas = @requisicao.requisitante.user.notificacoes_recebidas.nao_vista
  @contador = @notificacoes_recebidas.count
  

  respond_to do |format|
    format.js 
  end

end

private

def requisicao_params
  params.require(:requisicao).permit(:numero,:pernoite, :descricao, :numero_passageiros,:requisitante_id, :data_ida, :hora_ida, :periodo,:tipo_requisicao, :periodo_longo, :inicio, :fim, :posto_id, :preferencia_id,:data_volta,:hora_volta,:motivo_id,:tipo_carga,:rota_ids=>[],:pessoa_ids=>[],endereco_attributes: [:logradouro,:numero,:complemento,:estado_id,:cidade_id,:bairro_id,:cep,:endereco,:latitude,:longitude,:descricao])
end

def load_requisicao
  @requisicao = Requisicao.new(requisicao_params)
  @estado = Estado.find_by(:sigla=>"AP")
end

end
