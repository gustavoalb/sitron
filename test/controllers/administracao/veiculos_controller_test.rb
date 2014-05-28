# -*- encoding : utf-8 -*-
require 'test_helper'

class Administracao::VeiculosControllerTest < ActionController::TestCase
  setup do
    @administracao_veiculo = administracao_veiculos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:administracao_veiculos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create administracao_veiculo" do
    assert_difference('Administracao::Veiculo.count') do
      post :create, administracao_veiculo: { ano_fabricacao: @administracao_veiculo.ano_fabricacao, ano_modelo: @administracao_veiculo.ano_modelo, capacidade_carga: @administracao_veiculo.capacidade_carga, capacidade_passageiros: @administracao_veiculo.capacidade_passageiros, combustivel_id: @administracao_veiculo.combustivel_id, diracao: @administracao_veiculo.diracao, intens_obrigatorios: @administracao_veiculo.intens_obrigatorios, marca: @administracao_veiculo.marca, modalidade_id: @administracao_veiculo.modalidade_id, modelo: @administracao_veiculo.modelo, motor: @administracao_veiculo.motor, observacao: @administracao_veiculo.observacao, tipo: @administracao_veiculo.tipo, turno_id: @administracao_veiculo.turno_id }
    end

    assert_redirected_to administracao_veiculo_path(assigns(:administracao_veiculo))
  end

  test "should show administracao_veiculo" do
    get :show, id: @administracao_veiculo
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @administracao_veiculo
    assert_response :success
  end

  test "should update administracao_veiculo" do
    patch :update, id: @administracao_veiculo, administracao_veiculo: { ano_fabricacao: @administracao_veiculo.ano_fabricacao, ano_modelo: @administracao_veiculo.ano_modelo, capacidade_carga: @administracao_veiculo.capacidade_carga, capacidade_passageiros: @administracao_veiculo.capacidade_passageiros, combustivel_id: @administracao_veiculo.combustivel_id, diracao: @administracao_veiculo.diracao, intens_obrigatorios: @administracao_veiculo.intens_obrigatorios, marca: @administracao_veiculo.marca, modalidade_id: @administracao_veiculo.modalidade_id, modelo: @administracao_veiculo.modelo, motor: @administracao_veiculo.motor, observacao: @administracao_veiculo.observacao, tipo: @administracao_veiculo.tipo, turno_id: @administracao_veiculo.turno_id }
    assert_redirected_to administracao_veiculo_path(assigns(:administracao_veiculo))
  end

  test "should destroy administracao_veiculo" do
    assert_difference('Administracao::Veiculo.count', -1) do
      delete :destroy, id: @administracao_veiculo
    end

    assert_redirected_to administracao_veiculos_path
  end
end
