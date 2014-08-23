# -*- encoding : utf-8 -*-
app_path = File.expand_path(File.join(File.dirname(__FILE__), '..'))
$LOAD_PATH.unshift(app_path) unless $LOAD_PATH.include?(app_path)
require 'clockwork'
require 'config/boot'
require 'config/environment'

class Fila
  def deliver
    puts "Agora"
  end
end

require 'clockwork'

include Clockwork

every(30.seconds, 'Processando Fila do Pátio') { Delayed::Job.enqueue ProcessoFila.new }
every(10.seconds, 'Processando Fila do Pátio no Final de Semana',:if => lambda { |t| t.saturday? }) { Delayed::Job.enqueue ProcessoFilaFimSemana.new }
every(10.seconds, 'Processando Retorno do Serviço',:if => lambda { |t| t.saturday? }) { Delayed::Job.enqueue ProcessarRetornoAutomatico.new }

#every(1.day, 'Queueing scheduled job', :at => '14:17') { Delayed::Job.enqueue ScheduledJob.new }
