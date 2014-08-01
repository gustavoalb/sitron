class ProcessoFila
	def perform

		@requisicoes = Requisicao.na_data(Time.zone.now).na_hora.normal_agendada.aguardando
            @remetente = User.find_by(:role=>0)
            @semana = Time.zone.now.strftime("%U")
            @mes = Time.zone.now.month
            @ano = Time.zone.now.year
            
            if @requisicoes
                @requisicoes.each do |req|
                        @tipo = req.motivo.tipo
                        @postos = Posto.ativo.disponivel.na_data(Time.zone.now).order("position ASC").horas_livres?(req.previsao_horas,@semana,@ano)
                        
                        if (Time.zone.now + 5.minutes <= req.inicio )
                             
                            if !req.provisao.nil?
                                #verifica se a Requisição tem aprovisionamento
                                @postos = Posto.ativo.disponivel.na_data(Time.zone.now).order("position ASC").horas_livres?(req.previsao_horas,@semana,@ano)
                                
                                @postos.each do |p|
                                   if p.veiculo.id == req.provisao.veiculo_id
                                        req.confirmar_requisicao(p)
                                        puts "Definindo o Veiculo do tipo: #{p.veiculo.lote.tipo} para a Requisição: #{req.numero}"
                                        break
                                    else
                                        next
                                    end
                                end
                              #fim verifica se a Requisição tem aprovisionamento
                            elsif req.motivo and req.motivo.carga? and (req.numero_passageiros.nil? or req.numero_passageiros <=0)
                                #esta requisição poderá usar uma moto
                                                               
                                @postos = Posto.ativo.disponivel.na_data(Time.zone.now).order("position ASC").horas_livres?(req.previsao_horas,@semana,@ano)
                                
                                @postos.each do |p|
                                    
                                      if p.e_do_tipo?('motocicleta')
                                        req.confirmar_requisicao(p)
                                        puts "Definindo o Veiculo do tipo: #{p.veiculo.lote.tipo} para a Requisição: #{req.numero}"
                                        break
                                      elsif p.e_do_tipo?('passeio')
                                        req.confirmar_requisicao(p)
                                        puts "Definindo o Veiculo do tipo: #{p.veiculo.lote.tipo} para a Requisição: #{req.numero}"
                                        break
                                      elsif p.e_do_tipo?('picku-up')
                                        req.confirmar_requisicao(p)
                                        puts "Definindo o Veiculo do tipo: #{p.veiculo.lote.tipo} para a Requisição: #{req.numero}"
                                        break
                                      elsif p.e_do_tipo?('caminhao')
                                        req.confirmar_requisicao(p)
                                        puts "Definindo o Veiculo do tipo: #{p.veiculo.lote.tipo} para a Requisição: #{req.numero}"
                                        break
                                      else   
                                        next
                                       end
                                
                                end
                              #fim da requisição que pode usar moto

                            elsif req.motivo and req.motivo.carga? and (!req.numero_passageiros.nil? and req.numero_passageiros > 0 and req.numero_passageiros <=2)
                                #Requisição com Carga que tem Passageiros vai usar o Caminhão
                                
                                puts "Req: #{req.id} Eu sou uma Requisição que poder usar um Caminhão"
                                     @postos = Posto.ativo.disponivel.na_data(Time.zone.now).order("position ASC").horas_livres?(req.previsao_horas,@semana,@ano)
                                     @postos.each do |p|
                                          if p.e_do_tipo?('caminhao')
                                            req.confirmar_requisicao(p)
                                            puts "Definindo o Veiculo do tipo: #{p.veiculo.lote.tipo} para a Requisição: #{req.numero}"
                                            break
                                          else
                                            next
                                          end
                                     end

                                #fim requisição com Carga que usa Caminhão
                            elsif req.motivo and !req.motivo.carga? and req.motivo.passageiro? and (req.numero_passageiros > 0 and req.numero_passageiros <= 4)
                                #requisição que tem carga e um número de passageiros < 4

                                     @postos = Posto.ativo.disponivel.na_data(Time.zone.now).order("position ASC").horas_livres?(req.previsao_horas,@semana,@ano)
                                     @postos.each do |p|
                                          if p.e_do_tipo?('passeio')
                                            req.confirmar_requisicao(p)
                                            puts "Definindo o Veiculo do tipo: #{p.veiculo.lote.tipo} para a Requisição: #{req.numero}"
                                            break
                                          elsif p.veiculo.capacidade_passageiros <= req.numero_passageiros and (!p.e_do_tipo?('motocicleta') and !p.e_do_tipo?('caminhao') and !p.e_do_tipo?('van'))
                                            req.confirmar_requisicao(p)
                                            puts "Definindo o Veiculo do tipo: #{p.veiculo.lote.tipo} para a Requisição: #{req.numero}"
                                            break
                                          else
                                            next
                                          end
                                     end

                                #fim requisição que tem carga e um número de passageiros < 4
                            elsif req.motivo and req.motivo.carga? and (!req.numero_passageiros.nil? and req.numero_passageiros > 0 and req.numero_passageiros <=4)
                                #requisição que pode usar uma pickup
                                
                                     @postos = Posto.ativo.disponivel.na_data(Time.zone.now).order("position ASC").horas_livres?(req.previsao_horas,@semana,@ano)
                                     @postos.each do |p|
                                          if p.e_do_tipo?('pick-up')
                                            req.confirmar_requisicao(p)
                                            puts "Definindo o Veiculo do tipo: #{p.veiculo.lote.tipo} para a Requisição: #{req.numero}"
                                            break
                                          elsif p.veiculo.capacidade_passageiros <= req.numero_passageiros and (!p.e_do_tipo?('motocicleta') and !p.e_do_tipo?('caminhao') and !p.e_do_tipo?('van'))
                                            req.confirmar_requisicao(p)
                                            puts "Definindo o Veiculo do tipo: #{p.veiculo.lote.tipo} para a Requisição: #{req.numero}"
                                            break
                                          else
                                            next
                                          end
                                     end

                                #fim requisição que pode usar uma pickup
                            elsif req.motivo and !req.motivo.carga? and (!req.numero_passageiros.nil? and req.numero_passageiros > 0 and req.numero_passageiros > 4 and req.numero_passageiros <= 15)
                                #requisição que pode usar uma VAN

                                     @postos = Posto.ativo.disponivel.na_data(Time.zone.now).order("position ASC").horas_livres?(req.previsao_horas,@semana,@ano)
                                     @postos.each do |p|
                                          if p.e_do_tipo?('van')
                                            req.confirmar_requisicao(p)
                                            puts "Definindo o Veiculo do tipo: #{p.veiculo.lote.tipo} para a Requisição: #{req.numero}"
                                            break
                                          elsif p.veiculo.capacidade_passageiros <= req.numero_passageiros and (!p.e_do_tipo?('motocicleta') and !p.e_do_tipo?('caminhao') and !p.e_do_tipo?('passeio'))
                                            req.confirmar_requisicao(p)
                                            puts "Definindo o Veiculo do tipo: #{p.veiculo.lote.tipo} para a Requisição: #{req.numero}"
                                            break
                                          else
                                            #podemos procurar um jeito de dividir os passegeiros em varios veiculos
                                            next
                                          end
                                     end

                                #fim requisição que pode usar uma VAN 
                            else
                              next        
                            end

                        elsif 
                          req.cancelar_requisicao('Infelizmente o tempo para sua requisição ser confirmada finalizou')
                          next
                        end
                end
            end

	end

end