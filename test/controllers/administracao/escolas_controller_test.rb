require 'test_helper'

class Administracao::EscolasControllerTest < ActionController::TestCase
  setup do
    @administracao_escola = administracao_escolas(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:administracao_escolas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create administracao_escola" do
    assert_difference('Administracao::Escola.count') do
      post :create, administracao_escola: { codigo: @administracao_escola.codigo, dependencia_administrativa: @administracao_escola.dependencia_administrativa, municipio_id: @administracao_escola.municipio_id, nome: @administracao_escola.nome, telefone: @administracao_escola.telefone, zona: @administracao_escola.zona }
    end

    assert_redirected_to administracao_escola_path(assigns(:administracao_escola))
  end

  test "should show administracao_escola" do
    get :show, id: @administracao_escola
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @administracao_escola
    assert_response :success
  end

  test "should update administracao_escola" do
    patch :update, id: @administracao_escola, administracao_escola: { codigo: @administracao_escola.codigo, dependencia_administrativa: @administracao_escola.dependencia_administrativa, municipio_id: @administracao_escola.municipio_id, nome: @administracao_escola.nome, telefone: @administracao_escola.telefone, zona: @administracao_escola.zona }
    assert_redirected_to administracao_escola_path(assigns(:administracao_escola))
  end

  test "should destroy administracao_escola" do
    assert_difference('Administracao::Escola.count', -1) do
      delete :destroy, id: @administracao_escola
    end

    assert_redirected_to administracao_escolas_path
  end
end
