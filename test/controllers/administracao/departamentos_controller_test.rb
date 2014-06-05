require 'test_helper'

class Administracao::DepartamentosControllerTest < ActionController::TestCase
  setup do
    @administracao_departamento = administracao_departamentos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:administracao_departamentos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create administracao_departamento" do
    assert_difference('Administracao::Departamento.count') do
      post :create, administracao_departamento: { descricao: @administracao_departamento.descricao, entidade_id: @administracao_departamento.entidade_id, nome: @administracao_departamento.nome, responsavel_id: @administracao_departamento.responsavel_id }
    end

    assert_redirected_to administracao_departamento_path(assigns(:administracao_departamento))
  end

  test "should show administracao_departamento" do
    get :show, id: @administracao_departamento
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @administracao_departamento
    assert_response :success
  end

  test "should update administracao_departamento" do
    patch :update, id: @administracao_departamento, administracao_departamento: { descricao: @administracao_departamento.descricao, entidade_id: @administracao_departamento.entidade_id, nome: @administracao_departamento.nome, responsavel_id: @administracao_departamento.responsavel_id }
    assert_redirected_to administracao_departamento_path(assigns(:administracao_departamento))
  end

  test "should destroy administracao_departamento" do
    assert_difference('Administracao::Departamento.count', -1) do
      delete :destroy, id: @administracao_departamento
    end

    assert_redirected_to administracao_departamentos_path
  end
end
