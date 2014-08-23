# -*- encoding : utf-8 -*-
require "bundler/setup"
class ProcessarRetornoAutomatico
  def perform

    @requisicoes = Requisicao.na_data(Time.zone.now.end_of_week-1.day).finais_de_semana.em_servico
    @remetente = User.find_by(:role => 0)
    @semana = Time.zone.now.strftime("%U")
    @mes = Time.zone.now.month
    @ano = Time.zone.now.year

    @requisicoes.each do |r|
      if r.fim.hour == Time.zone.now.hour and r.fim.min == Time.zone.now.min
        @posto = r.posto
        @servico = Administracao::Servico.where(:requisicao_id => r.id, :veiculo_id => @posto.veiculo.id).first

        if @servico
          @servico.chegada = Time.zone.now
          @servico.save
        end
        r.data_volta = Time.zone.now
        r.hora_volta = Time.zone.now
        r.finalizar
        @posto.estacionar
      end
    end
  end

end