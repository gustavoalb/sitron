require File.expand_path('../../config/boot',        __FILE__)
require File.expand_path('../../config/environment', __FILE__)

class Fila
  def deliver
    puts "Agora"
  end

end

require 'clockwork'

include Clockwork

every(10.seconds, 'Processando Fila') { Delayed::Job.enqueue Fibra.new }
#every(1.day, 'Queueing scheduled job', :at => '14:17') { Delayed::Job.enqueue ScheduledJob.new }