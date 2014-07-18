require 'test_helper'

class Administracao::BancoDeHorasControllerTest < ActionController::TestCase
  setup do
    @administracao_banco_de_hora = administracao_banco_de_horas(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:administracao_banco_de_horas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create administracao_banco_de_hora" do
    assert_difference('Administracao::BancoDeHora.count') do
      post :create, administracao_banco_de_hora: { ano: @administracao_banco_de_hora.ano, dia: @administracao_banco_de_hora.dia, fim_semana: @administracao_banco_de_hora.fim_semana, horas_extras: @administracao_banco_de_hora.horas_extras, horas_normais: @administracao_banco_de_hora.horas_normais, inicio_semana: @administracao_banco_de_hora.inicio_semana, mes: @administracao_banco_de_hora.mes, numero_semana: @administracao_banco_de_hora.numero_semana, posto_id: @administracao_banco_de_hora.posto_id }
    end

    assert_redirected_to administracao_banco_de_hora_path(assigns(:administracao_banco_de_hora))
  end

  test "should show administracao_banco_de_hora" do
    get :show, id: @administracao_banco_de_hora
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @administracao_banco_de_hora
    assert_response :success
  end

  test "should update administracao_banco_de_hora" do
    patch :update, id: @administracao_banco_de_hora, administracao_banco_de_hora: { ano: @administracao_banco_de_hora.ano, dia: @administracao_banco_de_hora.dia, fim_semana: @administracao_banco_de_hora.fim_semana, horas_extras: @administracao_banco_de_hora.horas_extras, horas_normais: @administracao_banco_de_hora.horas_normais, inicio_semana: @administracao_banco_de_hora.inicio_semana, mes: @administracao_banco_de_hora.mes, numero_semana: @administracao_banco_de_hora.numero_semana, posto_id: @administracao_banco_de_hora.posto_id }
    assert_redirected_to administracao_banco_de_hora_path(assigns(:administracao_banco_de_hora))
  end

  test "should destroy administracao_banco_de_hora" do
    assert_difference('Administracao::BancoDeHora.count', -1) do
      delete :destroy, id: @administracao_banco_de_hora
    end

    assert_redirected_to administracao_banco_de_horas_path
  end
end
