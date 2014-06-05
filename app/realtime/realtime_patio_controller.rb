class RealtimePatioController < FayeRails::Controller
	channel '/patio' do
		subscribe do
			puts "Received on channel #{channel}: #{message.inspect}"
			ary = message.inspect.to_s.split('&')

			if Administracao::Veiculo.exists?(:id=>ary[1])
				veiculo = Administracao::Veiculo.find(ary[1])

				if veiculo.patios.na_data(Time.now).count > 0
                    
					patio = veiculo.patios.na_data(Time.now).last
					puts "ID do Pátio: #{patio.id}"
                    puts "Ação: #{ary[4].to_s}"

					case ary[4]
					when "ligar"
						patio.ligar
					when "sair"
						patio.sair
					when "quebrar"
						patio.quebrar
					when "agendar"
						patio.agendar
					when "consertar"
						patio.consertar
					end


				else
					Administracao::Patio.create(:veiculo_id=>ary[1],:empresa_id=> ary[2],:data_entrada=>Time.now)
				end
			end

		end



		monitor :publish do
			puts "Client #{client_id} published #{data.inspect} to #{channel}."
		end



	end


end