require 'test_helper'

class NotificacoesControllerTest < ActionController::TestCase
  setup do
    @notificacao = notificacoes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:notificacoes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create notificacao" do
    assert_difference('Notificacao.count') do
      post :create, notificacao: { entidade_id: @notificacao.entidade_id, motivo: @notificacao.motivo, origem_id: @notificacao.origem_id, posto_id: @notificacao.posto_id, state: @notificacao.state, texto: @notificacao.texto }
    end

    assert_redirected_to notificacao_path(assigns(:notificacao))
  end

  test "should show notificacao" do
    get :show, id: @notificacao
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @notificacao
    assert_response :success
  end

  test "should update notificacao" do
    patch :update, id: @notificacao, notificacao: { entidade_id: @notificacao.entidade_id, motivo: @notificacao.motivo, origem_id: @notificacao.origem_id, posto_id: @notificacao.posto_id, state: @notificacao.state, texto: @notificacao.texto }
    assert_redirected_to notificacao_path(assigns(:notificacao))
  end

  test "should destroy notificacao" do
    assert_difference('Notificacao.count', -1) do
      delete :destroy, id: @notificacao
    end

    assert_redirected_to notificacoes_path
  end
end
