# -*- encoding : utf-8 -*-
require 'test_helper'

class Administracao::RotasControllerTest < ActionController::TestCase
  setup do
    @administracao_rota = administracao_rotas(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:administracao_rotas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create administracao_rota" do
    assert_difference('Administracao::Rota.count') do
      post :create, administracao_rota: { destino: @administracao_rota.destino, entidade_id: @administracao_rota.entidade_id, intermunicipal: @administracao_rota.intermunicipal, latitude: @administracao_rota.latitude, longitude: @administracao_rota.longitude, rota_longa: @administracao_rota.rota_longa, tempo_previsto: @administracao_rota.tempo_previsto }
    end

    assert_redirected_to administracao_rota_path(assigns(:administracao_rota))
  end

  test "should show administracao_rota" do
    get :show, id: @administracao_rota
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @administracao_rota
    assert_response :success
  end

  test "should update administracao_rota" do
    patch :update, id: @administracao_rota, administracao_rota: { destino: @administracao_rota.destino, entidade_id: @administracao_rota.entidade_id, intermunicipal: @administracao_rota.intermunicipal, latitude: @administracao_rota.latitude, longitude: @administracao_rota.longitude, rota_longa: @administracao_rota.rota_longa, tempo_previsto: @administracao_rota.tempo_previsto }
    assert_redirected_to administracao_rota_path(assigns(:administracao_rota))
  end

  test "should destroy administracao_rota" do
    assert_difference('Administracao::Rota.count', -1) do
      delete :destroy, id: @administracao_rota
    end

    assert_redirected_to administracao_rotas_path
  end
end
