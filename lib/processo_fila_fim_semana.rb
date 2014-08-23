# -*- encoding : utf-8 -*-
require "bundler/setup"
class ProcessoFilaFimSemana
  def perform

    @requisicoes = Requisicao.na_data(Time.zone.now.end_of_week-1.day).na_hora.finais_de_semana.confirmada
    @remetente = User.find_by(:role => 0)
    @semana = Time.zone.now.strftime("%U")
    @mes = Time.zone.now.month
    @ano = Time.zone.now.year

    @requisicoes.each do |r|
       @posto = r.posto
       r.data_ida = Time.zone.now
       r.hora_ida = Time.zone.now
       r.ativar
       @posto.sair
       @servico = r.create_servico(:veiculo_id=>@posto.veiculo.id, :user_id=>@remetente.user_id, :empresa_id=>@posto.veiculo.empresa_id, :contrato_id=>@posto.veiculo.contrato_id,:lote=>@posto.veiculo.lote, :saida=> Time.zone.now,:valor_combustivel_centavos=>2.30)
    end
  end

end
