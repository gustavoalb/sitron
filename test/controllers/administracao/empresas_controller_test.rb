# -*- encoding : utf-8 -*-
require 'test_helper'

class Administracao::EmpresasControllerTest < ActionController::TestCase
  
  setup do
    @administracao_empresa = administracao_empresas(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:administracao_empresas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create administracao_empresa" do
    assert_difference('Administracao::Empresa.count') do
      post :create, administracao_empresa: { cnpj: @administracao_empresa.cnpj, endereco_id: @administracao_empresa.endereco_id, nome: @administracao_empresa.nome, responsavel_id: @administracao_empresa.responsavel_id }
    end

    assert_redirected_to administracao_empresa_path(assigns(:administracao_empresa))
  end

  test "should show administracao_empresa" do
    get :show, id: @administracao_empresa
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @administracao_empresa
    assert_response :success
  end

  test "should update administracao_empresa" do
    patch :update, id: @administracao_empresa, administracao_empresa: { cnpj: @administracao_empresa.cnpj, endereco_id: @administracao_empresa.endereco_id, nome: @administracao_empresa.nome, responsavel_id: @administracao_empresa.responsavel_id }
    assert_redirected_to administracao_empresa_path(assigns(:administracao_empresa))
  end

  test "should destroy administracao_empresa" do
    assert_difference('Administracao::Empresa.count', -1) do
      delete :destroy, id: @administracao_empresa
    end

    assert_redirected_to administracao_empresas_path
  end
end
