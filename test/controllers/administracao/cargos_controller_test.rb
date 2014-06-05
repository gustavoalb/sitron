require 'test_helper'

class Administracao::CargosControllerTest < ActionController::TestCase
  setup do
    @administracao_cargo = administracao_cargos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:administracao_cargos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create administracao_cargo" do
    assert_difference('Administracao::Cargo.count') do
      post :create, administracao_cargo: { entidade_id: @administracao_cargo.entidade_id, nome: @administracao_cargo.nome }
    end

    assert_redirected_to administracao_cargo_path(assigns(:administracao_cargo))
  end

  test "should show administracao_cargo" do
    get :show, id: @administracao_cargo
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @administracao_cargo
    assert_response :success
  end

  test "should update administracao_cargo" do
    patch :update, id: @administracao_cargo, administracao_cargo: { entidade_id: @administracao_cargo.entidade_id, nome: @administracao_cargo.nome }
    assert_redirected_to administracao_cargo_path(assigns(:administracao_cargo))
  end

  test "should destroy administracao_cargo" do
    assert_difference('Administracao::Cargo.count', -1) do
      delete :destroy, id: @administracao_cargo
    end

    assert_redirected_to administracao_cargos_path
  end
end
