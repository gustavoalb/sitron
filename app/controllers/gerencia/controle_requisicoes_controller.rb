class Gerencia::ControleRequisicoesController < ApplicationController
  def index
  	@requisicoes = Requisicao.aguardando.all
  	@postos = Posto.disponivel.na_data(Time.zone.now).order("position ASC")
  	
  end

  def definir_posto
    
  render :nothing=>true

  end
end
