require 'test_helper'

class MensagensControllerTest < ActionController::TestCase
  setup do
    @mensagem = mensagens(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:mensagens)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create mensagem" do
    assert_difference('Mensagem.count') do
      post :create, mensagem: { destinatario_id: @mensagem.destinatario_id, lido: @mensagem.lido, objeto_id: @mensagem.objeto_id, objeto_type: @mensagem.objeto_type, remetente_id: @mensagem.remetente_id, texto: @mensagem.texto, tipo_usuario: @mensagem.tipo_usuario }
    end

    assert_redirected_to mensagem_path(assigns(:mensagem))
  end

  test "should show mensagem" do
    get :show, id: @mensagem
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @mensagem
    assert_response :success
  end

  test "should update mensagem" do
    patch :update, id: @mensagem, mensagem: { destinatario_id: @mensagem.destinatario_id, lido: @mensagem.lido, objeto_id: @mensagem.objeto_id, objeto_type: @mensagem.objeto_type, remetente_id: @mensagem.remetente_id, texto: @mensagem.texto, tipo_usuario: @mensagem.tipo_usuario }
    assert_redirected_to mensagem_path(assigns(:mensagem))
  end

  test "should destroy mensagem" do
    assert_difference('Mensagem.count', -1) do
      delete :destroy, id: @mensagem
    end

    assert_redirected_to mensagens_path
  end
end
