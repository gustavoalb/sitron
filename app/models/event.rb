# -*- encoding : utf-8 -*-
class Event < ActiveRecord::Base
  has_event_calendar
  belongs_to :requisicao

  def color
    return self.requisicao.color  
  end
end
