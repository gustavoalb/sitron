# -*- encoding : utf-8 -*-
# Use this setup block to configure all options available in SimpleForm.
SimpleForm.setup do |config|
  config.boolean_style = :inline

  config.wrappers :bootstrap, tag: 'div', class: 'form-group', error_class: 'has-error' do |b|
    b.use :html5
    b.use :placeholder
    b.use :label
    b.wrapper tag: 'div', class: 'col-sm-6' do |ba|
      ba.use :input
      ba.use :error, wrap_with: { tag: 'p', class: 'help-inline help-block' }
      ba.use :hint,  wrap_with: { tag: 'p', class: 'hint' }
    end
  end

  config.wrappers :prepend, tag: 'div', class: "form-group", error_class: 'has-error' do |b|
    b.use :html5
    b.use :placeholder
    b.use :label
    b.wrapper tag: 'div', class: 'col-sm-6' do |input|
      input.wrapper tag: 'div', class: 'input-prepend' do |prepend|
        prepend.use :input
      end
      input.use :hint,  wrap_with: { tag: 'p', class: 'hint' }
      input.use :error, wrap_with: { tag: 'p', class: 'help-inline help-block' }
    end
  end

  config.wrappers :append, tag: 'div', class: "form-group", error_class: 'has-error' do |b|
    b.use :html5
    b.use :placeholder
    b.use :label
    b.wrapper tag: 'div', class: 'col-sm-6' do |input|
      input.wrapper tag: 'div', class: 'input-append' do |append|
        append.use :input
      end
      input.use :hint,  wrap_with: { tag: 'p', class: 'hint' }
      input.use :error, wrap_with: { tag: 'p', class: 'help-inline help-block' }
    end
  end



  config.wrappers :pequenos, tag: 'div', class: "form-group", error_class: 'has-error' do |b|
    b.use :html5
    b.use :placeholder
    b.use :label
    b.wrapper tag: 'div', class: 'col-sm-6' do |input|
      input.wrapper tag: 'div', class: 'col-sm-3' do |append|
        append.use :input
      end
      input.use :hint,  wrap_with: { tag: 'p', class: 'hint' }
      input.use :error, wrap_with: { tag: 'p', class: 'help-inline help-block' }
    end
  end


  config.wrappers :pequenos, tag: 'div', class: "form-group", error_class: 'has-error' do |b|
    b.use :html5
    b.use :placeholder
    b.use :label
    b.wrapper tag: 'div', class: 'col-sm-6' do |input|
      input.wrapper tag: 'div', class: 'col-sm-3' do |append|
        append.use :input
      end
      input.use :hint,  wrap_with: { tag: 'p', class: 'hint' }
      input.use :error, wrap_with: { tag: 'p', class: 'help-inline help-block' }
    end
  end


  config.wrappers :checkbox, tag: :div,class: "checkbox block",error_class: 'has-error' do |b|
   b.use :html5
   b.use :placeholder
   b.use :input
   b.use :hint,  wrap_with: { tag: 'p', class: 'hint' }
   b.use :error, wrap_with: { tag: 'p', class: 'help-inline help-block' }
 end

 config.wrappers :inline_radio,tag: 'div',item_wrapper_class: 'radio block', error_class: 'has-error' do |b|
   #b.use :html5
   b.use :label
   b.use :input
 end
  # Wrappers for forms and inputs using the Twitter Bootstrap toolkit.
  # Check the Bootstrap docs (http://twitter.github.com/bootstrap)
  # to learn about the different styles for forms and inputs,
  # buttons and other elements.
  config.default_wrapper = :bootstrap
end
