# -*- encoding : utf-8 -*-
require 'test_helper'

class Administracao::PessoasControllerTest < ActionController::TestCase
  setup do
    @administracao_pessoa = administracao_pessoas(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:administracao_pessoas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create administracao_pessoa" do
    assert_difference('Administracao::Pessoa.count') do
      post :create, administracao_pessoa: { cargo_id: @administracao_pessoa.cargo_id, cpf: @administracao_pessoa.cpf, email: @administracao_pessoa.email, matricula: @administracao_pessoa.matricula, nome: @administracao_pessoa.nome }
    end

    assert_redirected_to administracao_pessoa_path(assigns(:administracao_pessoa))
  end

  test "should show administracao_pessoa" do
    get :show, id: @administracao_pessoa
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @administracao_pessoa
    assert_response :success
  end

  test "should update administracao_pessoa" do
    patch :update, id: @administracao_pessoa, administracao_pessoa: { cargo_id: @administracao_pessoa.cargo_id, cpf: @administracao_pessoa.cpf, email: @administracao_pessoa.email, matricula: @administracao_pessoa.matricula, nome: @administracao_pessoa.nome }
    assert_redirected_to administracao_pessoa_path(assigns(:administracao_pessoa))
  end

  test "should destroy administracao_pessoa" do
    assert_difference('Administracao::Pessoa.count', -1) do
      delete :destroy, id: @administracao_pessoa
    end

    assert_redirected_to administracao_pessoas_path
  end
end
