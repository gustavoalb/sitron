class PatioController < ApplicationController


  def index

  	@postos = Posto.ativo.na_data(Time.zone.now).order("position ASC")
  	
  end


  def entrada

   @postos = Posto.ativo.na_data(Time.zone.now).order("lote_id, position ASC")

 end


 def saida
  @postos = Posto.ativo.na_data(Time.zone.now).order("position ASC")
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

  veiculo = Administracao::Veiculo.where(:codigo=>codigo).first || Administracao::Veiculo.where(:codigo_s=>codigo).first

  @patio = Administracao::Patio.na_data(Time.zone.now).first || Administracao::Patio.create(:data_entrada=>Time.now)

  @posto = Posto.create(:codigo=>codigo,:entrada=>Time.zone.now,:veiculo_id=>veiculo.id,:data_entrada=>Time.zone.now.to_date,:patio=>@patio,:modalidade_id=>veiculo.modalidade_id,:empresa_id=>veiculo.empresa_id,:contrato_id=>veiculo.contrato_id,:lote=>veiculo.lote,:turno=>Posto.setar_turno(Time.zone.now))

  @postos = Posto.ativo.na_data(Time.zone.now).order("position ASC")

end


def remover_posto
  codigo = params[:posto][:codigo_de_barras]
  veiculo = Administracao::Veiculo.where(:codigo=>codigo).first

  @patio = Administracao::Patio.na_data(Time.zone.now).first

  @postos = @patio.postos.ativo.na_data(Time.zone.now).order("position ASC")  

  @posto = @patio.postos.where(:veiculo_id=>veiculo.id).first

  @posto.sair_do_patio



end

def saida_servico 
  codigo = params[:posto][:codigo_de_barras]

  veiculo = Administracao::Veiculo.where(:codigo=>codigo).first

  @patio = Administracao::Patio.na_data(Time.zone.now).first
  @posto = @patio.postos.ativo.na_data(Time.zone.now).proximo_de_sair.where(:veiculo_id=>veiculo.id).first
  @postos = @patio.postos.ativo.na_data(Time.zone.now).order("position ASC")

  if @posto 

    @requisicao = Requisicao.confirmada.where(:posto_id=>@posto.id).first

    if @requisicao
      @servico = @requisicao.create_servico(:veiculo_id=>@posto.veiculo.id, :user_id=>@requisicao.requisitante.user_id, :empresa_id=>@posto.veiculo.empresa_id, :contrato_id=>@posto.veiculo.contrato_id,:lote=>@posto.veiculo.lote, :saida=> Time.zone.now,:valor_combustivel_centavos=>2.30)
      #if @servico
        @posto.sair
          #@requisicao.sair
          @requisicao.data_ida = Time.zone.now
          @requisicao.hora_ida = Time.zone.now
          @requisicao.save
        #end
      end
    end


  end




  def chegada_servico
    codigo = params[:posto][:codigo_de_barras]
    veiculo = Administracao::Veiculo.where(:codigo=>codigo).first
    @patio = Administracao::Patio.na_data(Time.zone.now).first
    @posto = @patio.postos.ativo.na_data(Time.zone.now).em_transito.where(:veiculo_id=>veiculo.id).first
    @postos = @patio.postos.ativo.na_data(Time.zone.now).order("position ASC")
  
    if @posto 

      @requisicao = Requisicao.confirmada.where(:posto_id=>@posto.id).first

      if @requisicao
        @servico = Administracao::Servico.where(:requisicao_id=>@requisicao.id, :veiculo_id=>@posto.veiculo.id, :user_id=>@requisicao.requisitante.user_id).first
        
        @servico.chegada = Time.zone.now
        @servico.atendido = true

        if @servico.save
          @posto.estacionar
          @requisicao.finalizar
          @requisicao.data_volta = Time.zone.now
          @requisicao.hora_volta = Time.zone.now
          @requisicao.save!

        end

      end

    end
  end






end
