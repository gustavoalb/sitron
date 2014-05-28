# -*- encoding : utf-8 -*-
require 'test_helper'

class Administracao::ModalidadesControllerTest < ActionController::TestCase
  setup do
    @administracao_modalidade = administracao_modalidades(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:administracao_modalidades)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create administracao_modalidade" do
    assert_difference('Administracao::Modalidade.count') do
      post :create, administracao_modalidade: { com_combustivel: @administracao_modalidade.com_combustivel, com_motorista: @administracao_modalidade.com_motorista, dias_mes: @administracao_modalidade.dias_mes, mes_completo: @administracao_modalidade.mes_completo, nome: @administracao_modalidade.nome, periodo_diario: @administracao_modalidade.periodo_diario, quilometragem_livre: @administracao_modalidade.quilometragem_livre }
    end

    assert_redirected_to administracao_modalidade_path(assigns(:administracao_modalidade))
  end

  test "should show administracao_modalidade" do
    get :show, id: @administracao_modalidade
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @administracao_modalidade
    assert_response :success
  end

  test "should update administracao_modalidade" do
    patch :update, id: @administracao_modalidade, administracao_modalidade: { com_combustivel: @administracao_modalidade.com_combustivel, com_motorista: @administracao_modalidade.com_motorista, dias_mes: @administracao_modalidade.dias_mes, mes_completo: @administracao_modalidade.mes_completo, nome: @administracao_modalidade.nome, periodo_diario: @administracao_modalidade.periodo_diario, quilometragem_livre: @administracao_modalidade.quilometragem_livre }
    assert_redirected_to administracao_modalidade_path(assigns(:administracao_modalidade))
  end

  test "should destroy administracao_modalidade" do
    assert_difference('Administracao::Modalidade.count', -1) do
      delete :destroy, id: @administracao_modalidade
    end

    assert_redirected_to administracao_modalidades_path
  end
end
