class PatioController < FayeRails::Controller
  channel '/patio' do
    subscribe do
      Rails.logger.debug "Um veículo entrou no pátio"

      puts "Estou Aqui"

      #ChatMessage.new(message['message'], created_at)
      Administracao::Patio.create(data_entrada: Time.now,data_saida: Time.now+8.hour)
    end
  end
end