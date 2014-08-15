# -*- encoding : utf-8 -*-
require 'test_helper'

class Administracao::MotivosControllerTest < ActionController::TestCase
  setup do
    @administracao_motivo = administracao_motivos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:administracao_motivos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create administracao_motivo" do
    assert_difference('Administracao::Motivo.count') do
      post :create, administracao_motivo: { carga: @administracao_motivo.carga, entrega_documento: @administracao_motivo.entrega_documento, interior: @administracao_motivo.interior, nome: @administracao_motivo.nome, passageiro: @administracao_motivo.passageiro, tipo_id: @administracao_motivo.tipo_id, viagem_longa: @administracao_motivo.viagem_longa }
    end

    assert_redirected_to administracao_motivo_path(assigns(:administracao_motivo))
  end

  test "should show administracao_motivo" do
    get :show, id: @administracao_motivo
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @administracao_motivo
    assert_response :success
  end

  test "should update administracao_motivo" do
    patch :update, id: @administracao_motivo, administracao_motivo: { carga: @administracao_motivo.carga, entrega_documento: @administracao_motivo.entrega_documento, interior: @administracao_motivo.interior, nome: @administracao_motivo.nome, passageiro: @administracao_motivo.passageiro, tipo_id: @administracao_motivo.tipo_id, viagem_longa: @administracao_motivo.viagem_longa }
    assert_redirected_to administracao_motivo_path(assigns(:administracao_motivo))
  end

  test "should destroy administracao_motivo" do
    assert_difference('Administracao::Motivo.count', -1) do
      delete :destroy, id: @administracao_motivo
    end

    assert_redirected_to administracao_motivos_path
  end
end
