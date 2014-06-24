require 'test_helper'

class Administracao::ContratosControllerTest < ActionController::TestCase
  setup do
    @administracao_contrato = administracao_contratos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:administracao_contratos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create administracao_contrato" do
    assert_difference('Administracao::Contrato.count') do
      post :create, administracao_contrato: { artigo: @administracao_contrato.artigo, empresa_id: @administracao_contrato.empresa_id, lei: @administracao_contrato.lei, numero: @administracao_contrato.numero }
    end

    assert_redirected_to administracao_contrato_path(assigns(:administracao_contrato))
  end

  test "should show administracao_contrato" do
    get :show, id: @administracao_contrato
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @administracao_contrato
    assert_response :success
  end

  test "should update administracao_contrato" do
    patch :update, id: @administracao_contrato, administracao_contrato: { artigo: @administracao_contrato.artigo, empresa_id: @administracao_contrato.empresa_id, lei: @administracao_contrato.lei, numero: @administracao_contrato.numero }
    assert_redirected_to administracao_contrato_path(assigns(:administracao_contrato))
  end

  test "should destroy administracao_contrato" do
    assert_difference('Administracao::Contrato.count', -1) do
      delete :destroy, id: @administracao_contrato
    end

    assert_redirected_to administracao_contratos_path
  end
end
