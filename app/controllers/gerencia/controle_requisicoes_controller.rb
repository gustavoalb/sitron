class Gerencia::ControleRequisicoesController < ApplicationController
  def index
  	@requisicoes = Requisicao.aguardando.all
  	@postos = Posto.ativo.na_data(Time.zone.now).order("position ASC")
  	
  end

  def definir_posto
     @requisicao = Requisicao.find(params[:requisicao][:id])
     @posto = Posto.ativo.find(params[:requisicao][:posto])

     @requisicao.posto = @posto
     @requisicao.confirmar
     @posto.ligar


     respond_to do |format|
      if @requisicao.save
        format.html { redirect_to gerencia_controle_requisicoes_index_url, notice: 'Posto Definido com Sucesso' }
      else
        format.html { redirect_to gerencia_controle_requisicoes_index_url, alert: 'Ocorreu um problema, por favor tente novamente.'  }
        format.json { render json: @administracao_rota.errors, status: :unprocessable_entity }
      end
    end

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
