# -*- encoding : utf-8 -*-
require 'test_helper'

class Administracao::ConfiguracoesControllerTest < ActionController::TestCase
  setup do
    @administracao_configuracao = administracao_configuracoes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:administracao_configuracoes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create administracao_configuracao" do
    assert_difference('Administracao::Configuracao.count') do
      post :create, administracao_configuracao: { index: @administracao_configuracao.skin, salvar_configuracao: @administracao_configuracao.salvar_configuracao }
    end

    assert_redirected_to administracao_configuracao_path(assigns(:administracao_configuracao))
  end

  test "should show administracao_configuracao" do
    get :show, id: @administracao_configuracao
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @administracao_configuracao
    assert_response :success
  end

  test "should update administracao_configuracao" do
    patch :update, id: @administracao_configuracao, administracao_configuracao: { index: @administracao_configuracao.skin, salvar_configuracao: @administracao_configuracao.salvar_configuracao }
    assert_redirected_to administracao_configuracao_path(assigns(:administracao_configuracao))
  end

  test "should destroy administracao_configuracao" do
    assert_difference('Administracao::Configuracao.count', -1) do
      delete :destroy, id: @administracao_configuracao
    end

    assert_redirected_to administracao_configuracoes_path
  end
end
