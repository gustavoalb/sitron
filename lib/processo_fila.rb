class ProcessoFila
	def perform

		@requisicoes = Requisicao.na_data(Time.zone.now).na_hora(Time.zone.now).normal_agendada.aguardando
		@remetente = User.find_by(:role=>0)
		@semana = Time.zone.now.strftime("%U")
		@mes = Time.zone.now.month
		@ano = Time.zone.now.year



		@requisicoes.each do |req|

			@postos = Posto.ativo.disponivel.na_data(Time.zone.now).order("position ASC")	
			@postos.each do |p|

				@tipo = p.veiculo.lote.tipo.remover_acentos.downcase

				if req.previsao_horas_extras <= p.veiculo.horas_extras_semanais(@semana,@mes,@ano)

					if req.motivo.tipo.nome.remover_acentos.downcase == @tipo and req.numero_passageiros <= p.veiculo.capacidade_passageiros
						req.posto = p 
						req.confirmar
						p.ligar
						break
					elsif req.numero_passageiros <= p.veiculo.capacidade_passageiros
						req.posto = p 
						req.confirmar
						p.ligar
						break
					elsif Time.zone.now + 15.minutes <= req.hora_ida.in_time_zone 
						requisicao.motivo_cancelamento = "Nenhum posto no pátio atendia ao requerimento no momento!"
						requisicao.cancelar
						Mensagem.create(:remetente=>@remetente,:texto=>"Sua Requisição foi cancelada, você precisa criar outra requisicao, o motivo foi: Nenhum posto no pátio atendia ao requerimento no momento!",:destinatario=>req.requisitante.user)
						break
					end

				else
					break
				end

			end
		end




	end

end