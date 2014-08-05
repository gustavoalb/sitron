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
#every(1.day, 'Queueing scheduled job', :at => '14:17') { Delayed::Job.enqueue ScheduledJob.new }