class PatioController < ApplicationController
  include ActionController::Live

 

  def index

  	@postos = Posto.ativo.na_data(Time.zone.now).order("position ASC")

  	
  end


  def entrada
   @postos_comuns = Posto.ativo.na_data(Time.zone.now).order("lote_id, position ASC")
   @postos_especiais = Posto.especiais.na_data(Time.zone.now).order("lote_id, position ASC")
   @postos = @postos_comuns + @postos_especiais
 end


 def saida
  @postos = Posto.ativo.na_data(Time.zone.now).order("position ASC")
end

def chat
 @mensagem = params[:posto][:mensagem]
 respond_to do |f|
  f.js 
end
end



def ordernar_veiculo
  @postos = Posto.all
  @postos.each do |atr|
    atr.position = params['veiculo'].index(atr.id.to_s) + 1
    atr.save!
  end
  render :nothing => true
end


def adicionar_posto

  codigo = params[:posto][:codigo_de_barras]
  @patio = Administracao::Patio.na_data(Time.zone.now).first || Administracao::Patio.create(:data_entrada=>Time.now)
  @ja_adicionado = nil
  posto = @patio.postos.find_by(:codigo=>codigo,:turno=>Posto.setar_turno(Time.zone.now))

  if !posto.nil? 
    @ja_adicionado = true
  else

    veiculo = Administracao::Veiculo.where(:codigo=>codigo).first || Administracao::Veiculo.where(:codigo_s=>codigo).first
    if veiculo
      @posto = @patio.postos.create!(:codigo=>codigo,:entrada=>Time.zone.now,:veiculo_id=>veiculo.id,:data_entrada=>Time.zone.now.to_date,:patio=>@patio,:modalidade_id=>veiculo.modalidade_id,:empresa_id=>veiculo.empresa_id,:contrato_id=>veiculo.contrato_id,:lote=>veiculo.lote,:turno=>Posto.setar_turno(Time.zone.now))
      @postos = Posto.ativo.na_data(Time.now).order("position ASC")
      @ja_adicionado = false
    else
      @nao_existe = true
    end
  end

  respond_to do |format|
    format.js
  end

end


def remover_posto
  codigo = params[:posto][:codigo_de_barras]
  veiculo = Administracao::Veiculo.where(:codigo=>codigo).first

  @patio = Administracao::Patio.na_data(Time.zone.now).first

  @postos = @patio.postos.ativo.na_data(Time.zone.now).order("position ASC")  

  @posto = @postos.find_by(:codigo=>codigo)

  if @posto 
    @posto.saida = Time.zone.now
    @posto.sair_do_patio
  else
    @mensagem = "Nenhum posto foi encontrado com este código"
  end

  respond_to do |format|
    format.js
  end


end

def saida_servico 
  codigo = params[:posto][:codigo_de_barras]
  @requisicao = Requisicao.confirmada.find_by(:codigo=>codigo)
  @mensagem = nil

  
  if @requisicao

    @patio = Administracao::Patio.na_data(Time.zone.now).first
    @posto = @requisicao.posto
    @postos = @patio.postos.ativo.na_data(Time.zone.now).order("position ASC")

    if @posto and @posto.saida_proxima?

      @servico = @requisicao.create_servico(:veiculo_id=>@posto.veiculo.id, :user_id=>@requisicao.requisitante.user_id, :empresa_id=>@posto.veiculo.empresa_id, :contrato_id=>@posto.veiculo.contrato_id,:lote=>@posto.veiculo.lote, :saida=> Time.zone.now,:valor_combustivel_centavos=>2.30)
      @posto.sair
      @requisicao.data_ida = Time.zone.now
      @requisicao.hora_ida = Time.zone.now
      @requisicao.save
      
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
  codigo = params[:posto][:codigo_de_barras]
  @requisicao = Requisicao.confirmada.find_by(:codigo=>codigo)
  @mensagem = nil

  
  if @requisicao
    @patio = Administracao::Patio.na_data(Time.zone.now).first
    @posto = @requisicao.posto
    veiculo = @posto.veiculo
    @postos = @patio.postos.ativo.na_data(Time.zone.now).order("position ASC")

    if @posto and @posto.em_transito?
      @servico = Administracao::Servico.where(:requisicao_id=>@requisicao.id, :veiculo_id=>@posto.veiculo.id, :user_id=>@requisicao.requisitante.user_id).first
      @servico.chegada = Time.zone.now
      if @servico.save
       @posto.estacionar
       @requisicao.data_volta = Time.zone.now
       @requisicao.hora_volta = Time.zone.now
       @requisicao.motivo_cancelamento = "É Só pra saber se está tudo ok!"
       @requisicao.finalizar
       @servico.atendido = true
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






end
