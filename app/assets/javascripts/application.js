// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery.turbolinks
//= require jquery_ujs
//= require bootstrap
//= require turbolinks
//= require_tree .



jQuery(function($){
  $('.date').mask('11/11/1111');
  $('.time').mask('00:00:00');
  $('.date_time').mask('00/00/0000 00:00:00');
  $('.cep').mask('00000-000');
  $('.ano').mask('0000');
  $('.fone').mask('(96)0000-0000');
  $('.chapa').mask('SSS-0000', {translation: {'Z': {pattern: /[A-Z]/, optional: false}}});
  $('.phone_with_ddd').mask('(00) 0000-0000');
  $('.phone_us').mask('(000) 000-0000');
  $('.mixed').mask('AAA 000-S0S');

  $('.cpf').mask('000.000.000-00', {reverse: true});
  $('.cnpj').mask('00.000.000/0000-00', {reverse: true});
  $('.money').mask("#.##0,00", {reverse: true, maxlength: false});
  $('.money2').mask("#.##0,00", {reverse: true, maxlength: false});
  $('.ip_address').mask('0ZZ.0ZZ.0ZZ.0ZZ', {translation: {'Z': {pattern: /[0-9]/, optional: true}}});
  $('.ip_address').mask('099.099.099.099');
  $('.percent').mask('##0,00%', {reverse: true});
}); 



jQuery.fn.observe_field = function(frequency, callback) {
    return this.each(function(){
        var element = $(this);
        var prev = element.val();

        var chk = function() {
            var val = element.val();
            if(prev != val){
                prev = val;
element.map(callback); // invokes the callback on the element
}
};
chk();
frequency = frequency * 1000; // translate to milliseconds
var ti = setInterval(chk, frequency);
// reset counter after user interaction
element.bind('keyup', function() {
    ti && clearInterval(ti);
    ti = setInterval(chk, frequency);
});
});

};

