class PatioController < ApplicationController

  
  def index

  	@patios = Administracao::Patio.order("position ASC")
  	
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
  dados = Base64.decode64(codigo)
  id = dados.split('&').first.to_i
  veiculo = Administracao::Veiculo.find(id)
  
  @patio = Administracao::Patio.create(:veiculo_id=>veiculo.id,:empresa_id=> veiculo.empresa_id,:data_entrada=>Time.now)
  @patios = Administracao::Patio.order("position ASC")

end




end
