# -*- encoding : utf-8 -*-
require 'test_helper'

class RequisicoesControllerTest < ActionController::TestCase
  setup do
    @requisicao = requisicoes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:requisicoes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create requisicao" do
    assert_difference('Requisicao.count') do
      post :create, requisicao: { data: @requisicao.data, descricao: @requisicao.descricao, fim: @requisicao.fim, hora: @requisicao.hora, inicio: @requisicao.inicio, numero: @requisicao.numero, periodo: @requisicao.periodo, periodo_longo: @requisicao.periodo_longo, posto_id: @requisicao.posto_id, prefencia_id: @requisicao.prefencia_id, requisitante_id: @requisicao.requisitante_id, tipo_deslocamento: @requisicao.tipo_deslocamento }
    end

    assert_redirected_to requisicao_path(assigns(:requisicao))
  end

  test "should show requisicao" do
    get :show, id: @requisicao
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @requisicao
    assert_response :success
  end

  test "should update requisicao" do
    patch :update, id: @requisicao, requisicao: { data: @requisicao.data, descricao: @requisicao.descricao, fim: @requisicao.fim, hora: @requisicao.hora, inicio: @requisicao.inicio, numero: @requisicao.numero, periodo: @requisicao.periodo, periodo_longo: @requisicao.periodo_longo, posto_id: @requisicao.posto_id, prefencia_id: @requisicao.prefencia_id, requisitante_id: @requisicao.requisitante_id, tipo_deslocamento: @requisicao.tipo_deslocamento }
    assert_redirected_to requisicao_path(assigns(:requisicao))
  end

  test "should destroy requisicao" do
    assert_difference('Requisicao.count', -1) do
      delete :destroy, id: @requisicao
    end

    assert_redirected_to requisicoes_path
  end
end
