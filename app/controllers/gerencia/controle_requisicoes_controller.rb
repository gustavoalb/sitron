class Gerencia::ControleRequisicoesController < ApplicationController
  def index
  	@requisicoes = Requisicao.aguardando.all
   @postos = Posto.ativo.na_data(Time.zone.now).order("position ASC")

 end

def definir_posto
  @requisicao = Requisicao.find(params[:req_id])
  @posto = Posto.ativo.find(params[:posto_id])
  @veiculo = @posto.veiculo
  mes = @requisicao.data_ida.month
  ano = @requisicao.data_ida.year
  @confirmada = nil

  if @veiculo.validar_horas_extras(@requisicao.previsao_horas_extras,@requisicao.data_ida.strftime("%U"),mes,ano)
     @requisicao.posto = @posto
     @requisicao.confirmar
     @posto.ligar
    @confirmada = true
    @mensagem = "O Posto foi definido com sucesso para a Requisição   #{@requisicao.numero}</strong>"
   else
    @confirmada = false
    @mensagem = 'O Posto selecionado Ultrapassará as horas extras permitidas com esta requisição.'
  end

  @requisicoes = Requisicao.aguardando.all
  @postos = Posto.ativo.na_data(Time.zone.now).order("position ASC")
end


def detalhes_requisicao
 @requisicao = Requisicao.find(params[:requisicao_id])
 @notificacao = Notificacao.find(params[:notificacao_id])
 @postos = Posto.ativo.na_data(Time.zone.now).order("position ASC")
end


def cancelar_requisicao
  @requisicao = Requisicao.find(params[:requisicao])
  @requisicao.cancelar

  Mensagem.create(:remetente=>current_user,:texto=>"Sua Requisição #{ActionController::Base.helpers.link_to @requisicao.id,requisicao_url(@requisicao.id)} foi cancelada, você precisa criar outra requisicao",:destinatario=>@requisicao.requisitante.user)

  redirect_to gerencia_controle_requisicoes_index_url, alert: "A requisição #{@requisicao.id} de #{@requisicao.requisitante.nome} foi cancelada"
end
end
