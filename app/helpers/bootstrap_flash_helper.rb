# -*- encoding : utf-8 -*-
module BootstrapFlashHelper
  def bootstrap_flash
    flash_messages = []
    flash.each do |type, message|
      # Skip Devise :timeout and :timedout flags
      next if type == :timeout
      next if type == :timedout
      type = :success if type == :notice
      type = :error if type == :alert
      text = content_tag(:div,
               content_tag(:button, raw("&times;"), :type=>"button",:class => "close", "data-dismiss" => "alert","aria-hidden"=>"true") +
               message, :class => "alert fade in alert-#{type} alert-dismissable")
      flash_messages << text if message
    end
    flash_messages.join("\n").html_safe
  end

  def flash_alert(alerta)

    flash_messages = []

    text = content_tag(:div,
               content_tag(:button, raw("&times;"), :type=>"button",:class => "close", "data-dismiss" => "alert","aria-hidden"=>"true") +
               alerta, :class => "alert fade in alert-danger alert-dismissable")
    flash_messages << text
    flash_messages.join("\n").html_safe
  end

  
  

end

