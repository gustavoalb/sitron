require 'test_helper'

class Administracao::CombustiveisControllerTest < ActionController::TestCase
  setup do
    @administracao_combustivel = administracao_combustiveis(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:administracao_combustiveis)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create administracao_combustivel" do
    assert_difference('Administracao::Combustivel.count') do
      post :create, administracao_combustivel: { nome: @administracao_combustivel.nome, valor: @administracao_combustivel.valor }
    end

    assert_redirected_to administracao_combustivel_path(assigns(:administracao_combustivel))
  end

  test "should show administracao_combustivel" do
    get :show, id: @administracao_combustivel
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @administracao_combustivel
    assert_response :success
  end

  test "should update administracao_combustivel" do
    patch :update, id: @administracao_combustivel, administracao_combustivel: { nome: @administracao_combustivel.nome, valor: @administracao_combustivel.valor }
    assert_redirected_to administracao_combustivel_path(assigns(:administracao_combustivel))
  end

  test "should destroy administracao_combustivel" do
    assert_difference('Administracao::Combustivel.count', -1) do
      delete :destroy, id: @administracao_combustivel
    end

    assert_redirected_to administracao_combustiveis_path
  end
end
