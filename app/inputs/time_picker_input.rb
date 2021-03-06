# -*- encoding : utf-8 -*-


class TimePickerInput < SimpleForm::Inputs::StringInput
  def input
    value = object.send(attribute_name) if object.respond_to? attribute_name
    input_html_options[:value] ||= I18n.localize(value, :format => '%R') if value.present?
    input_html_classes << "timepicker"

    super # leave StringInput do the real rendering
  end
end
