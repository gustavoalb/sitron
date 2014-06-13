class PatioController < ApplicationController

  
  def index

  	@patios = Administracao::Patio.na_data(Time.zone.now).order("position ASC")
  	
  end


    def entrada

    @patios = Administracao::Patio.na_data(Time.zone.now).order("position ASC")
    
  end

  def saida
    @patios = Administracao::Patio.na_data(Time.zone.now).order("position ASC")
  end



def ordernar_veiculo
  @patios = Administracao::Patio.all
  @patios.each do |atr|
    atr.position = params['veiculo'].index(atr.id.to_s) + 1
    atr.save!
  end
  render :nothing => true
end


def adicionar_posto
  codigo = params[:posto][:codigo_de_barras]
  veiculo = Administracao::Veiculo.where(:codigo=>codigo).first
  @patio = Administracao::Patio.create(:veiculo_id=>veiculo.id,:empresa_id=> veiculo.empresa_id,:data_entrada=>Time.now)
  @patios = Administracao::Patio.na_data(Time.zone.now).order("position ASC")
end


def remover_posto
  codigo = params[:posto][:codigo_de_barras]
  veiculo = Administracao::Veiculo.where(:codigo=>codigo).first
  @patio = Administracao::Patio.where(:veiculo_id=>veiculo.id).first
  @patio.destroy
  @patios = Administracao::Patio.na_data(Time.zone.now).order("position ASC")
end





end
