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
//= require jquery-ui
//= require bootstrap
//= require turbolinks
//= require moment
//= require moment/pt-br.js
//= require underscore
//= require gmaps/google
//= require jquery_nested_form
//= require dataTables/jquery.dataTables
//= require dataTables/bootstrap/3/jquery.dataTables.bootstrap
//= require bootstrap-select
//= require bootbox
//= require private_pub
//= require bootstrap-daterangepicker
//= require bootstrap-timepicker
//= require bootstrap-multiselect

//= require_tree .



jQuery(function($){
  $('.date').mask('11/11/1111');
  $('.time').mask('00:00:00');
  $('.date_time').mask('00/00/0000 00:00:00');
  $('.cep').mask('00000-000');
  $('.ano').mask('0000');
  $('.fone').mask('(96)0000-0000');
  $('.chapa').mask('SSS-0000', {translation: {'S': {pattern: /[A-Z]/, optional: false}}});
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



function getDestinosByTipoId(tipo_destino) {
  $.getJSON("/administracao/rotas/tipo_destino?tipo_destino="+tipo_destino, function(j) {
    var options = '<option value="">Selecione o Destino</option>';
    $.each(j.response, function(i, item) {
      options += '<option value="' + item.id + '">' + item.n + '</option>';
    });
    $("#destino_id").html(options);
  });
}



function getLotesByModalidadeId(modalidade) {
  $.getJSON("/administracao/veiculos/listar_lotes?modalidade_id="+modalidade, function(j) {
    var options = '<option value="">Selecione o Lote</option>';
    $.each(j.response, function(i, item) {
      options += '<option value="' + item.id + '">' + item.n + '</option>';
    });
    $("#administracao_veiculo_lote_id").html(options);
  });
}




function getCidadesByEstadoId(estado_id) {
  $.getJSON("/administracao/departamentos/listar_cidades?estado_id="+estado_id, function(j) {
    var options = '<option value="">Selecione a Cidade</option>';
    $.each(j.response, function(i, item) {
      options += '<option value="' + item.id + '">' + item.n + '</option>';
    });
    $("#departamento_cidade_select").html(options);
  });
}







function getDestinoByDestinoId(destino_id,classe) {
  $.getJSON("/administracao/rotas/destino?destino_id="+destino_id+"&classe="+classe, function(j) {
    var latitude = '';
    var longitude = '';
    $.each(j.response, function(i, item) {
      latitude += item.latitude;
      longitude += item.longitude;
    });
    $("#administracao_rota_longitude").val(longitude);
    $("#administracao_rota_latitude").val(latitude);
  });
}


function getLatitudeLongitudeByCidadeId(cidade_id) {
  $.getJSON("/administracao/departamentos/lat_lng_cidade?cidade_id="+cidade_id, function(j) {
    var latitude = '';
    var longitude = '';
    $.each(j.response, function(i, item) {
      latitude += item.latitude;
      longitude += item.longitude;
    });
    $("#administracao_departamento_endereco_attributes_longitude").val(longitude);
    $("#administracao_departamento_endereco_attributes_latitude").val(latitude);
  });
}



function getLatitudeLongitudeByCidadeBId(cidade_id) {
  $.getJSON("/administracao/departamentos/lat_lng_cidade?cidade_id="+cidade_id, function(j) {
    var latitude = '';
    var longitude = '';
    $.each(j.response, function(i, item) {
      latitude += item.latitude;
      longitude += item.longitude;
    });
    $("#administracao_empresa_endereco_attributes_longitude").val(longitude);
    $("#administracao_empresa_endereco_attributes_latitude").val(latitude);
  });
}


function getLatitudeLongitudeRequisicao(cidade_id) {
  $.getJSON("/requisicoes/lat_lng_cidade?cidade_id="+cidade_id, function(j) {
    var latitude = '';
    var longitude = '';
    $.each(j.response, function(i, item) {
      latitude += item.latitude;
      longitude += item.longitude;
    });
    $("#requisicao_endereco_attributes_longitude").val(longitude);
    $("#requisicao_endereco_attributes_latitude").val(latitude);
  });
}



function updateCountdown() {
    // 160 is the max message length
    var remaining = 160 - jQuery('.mensagem').val().length;
    jQuery('.contagem_caracteres').text(remaining + ' caracteres sobrando.');}


