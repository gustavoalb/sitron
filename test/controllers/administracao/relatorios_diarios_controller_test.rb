require 'test_helper'

class Administracao::RelatoriosDiariosControllerTest < ActionController::TestCase
  setup do
    @administracao_relatorios_diario = administracao_relatorios_diarios(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:administracao_relatorios_diarios)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create administracao_relatorios_diario" do
    assert_difference('Administracao::RelatoriosDiario.count') do
      post :create, administracao_relatorios_diario: { data: @administracao_relatorios_diario.data, descricao: @administracao_relatorios_diario.descricao, tipo: @administracao_relatorios_diario.tipo }
    end

    assert_redirected_to administracao_relatorios_diario_path(assigns(:administracao_relatorios_diario))
  end

  test "should show administracao_relatorios_diario" do
    get :show, id: @administracao_relatorios_diario
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @administracao_relatorios_diario
    assert_response :success
  end

  test "should update administracao_relatorios_diario" do
    patch :update, id: @administracao_relatorios_diario, administracao_relatorios_diario: { data: @administracao_relatorios_diario.data, descricao: @administracao_relatorios_diario.descricao, tipo: @administracao_relatorios_diario.tipo }
    assert_redirected_to administracao_relatorios_diario_path(assigns(:administracao_relatorios_diario))
  end

  test "should destroy administracao_relatorios_diario" do
    assert_difference('Administracao::RelatoriosDiario.count', -1) do
      delete :destroy, id: @administracao_relatorios_diario
    end

    assert_redirected_to administracao_relatorios_diarios_path
  end
end
