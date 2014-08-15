# -*- encoding : utf-8 -*-
class RadioButtonsLeftLabelInput < SimpleForm::Inputs::CollectionRadioButtonsInput
  def input
    label_method, value_method = detect_collection_methods

    @builder.send("collection_radio_buttons",
      attribute_name, collection, value_method, label_method,
      input_options, &collection_block_for_nested_boolean_style
    )
  end


end
