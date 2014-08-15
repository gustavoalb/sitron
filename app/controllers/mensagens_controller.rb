# -*- encoding : utf-8 -*-
class MensagensController < ApplicationController
  before_action :set_mensagem, only: [:show, :edit, :update, :destroy]

  # GET /mensagens
  # GET /mensagens.json
  def index
    @mensagens = Mensagem.para_o_usuario(current_user).nao_lidas.order(created_at: :desc)|Mensagem.tipo_usuario(current_user.role).nao_lidas.order("created_at ASC").all
    @mensagens_lidas = Mensagem.para_o_usuario(current_user).lidas.order(created_at: :desc)|Mensagem.tipo_usuario(current_user.role).lidas.order("created_at ASC").all
  
  end

  # GET /mensagens/1
  # GET /mensagens/1.json
  def show
  end

  def marcar_lida
   @mensagens = Mensagem.para_o_usuario(current_user).nao_lidas|Mensagem.tipo_usuario(current_user.role).nao_lidas if current_user
   @mensagens.each do |m|
    m.ler
   end

  end

  # GET /mensagens/new
  def new
    @mensagem = Mensagem.new
    @destinatarios = User.all.collect{|u| ["#{u.pessoa.nome} - #{u.role.upcase}",u.id]}
  end

  def ler
    @mensagem = Mensagem.find(params[:mensagem_id])
    @mensagem.ler
  end

  # GET /mensagens/1/edit
  def edit
  end

  # POST /mensagens
  # POST /mensagens.json
  def create
    @mensagem = Mensagem.new(mensagem_params)

    respond_to do |format|
      if @mensagem.save
        @contador = @mensagem.destinatario.mensagens_recebidas.nao_lidas.count
        @mensagens_recebidas = @mensagem.destinatario.mensagens_recebidas.limit(3).nao_lidas

        format.html { redirect_to mensagens_url, notice: 'Sua Mensagem foi enviada! ' }
        format.json { render :show, status: :created, location: @mensagem }
        format.js
      else
        format.html { render :new }
        format.json { render json: @mensagem.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /mensagens/1
  # PATCH/PUT /mensagens/1.json
  def update
    respond_to do |format|
      if @mensagem.update(mensagem_params)
        format.html { redirect_to @mensagem, notice: 'Mensagem foi atualizado com sucesso.' }
        format.json { render :show, status: :ok, location: @mensagem }
      else
        format.html { render :edit }
        format.json { render json: @mensagem.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /mensagens/1
  # DELETE /mensagens/1.json
  def destroy
    @mensagem.destroy
    respond_to do |format|
      format.html { redirect_to mensagens_url, notice: 'Mensagem foi removido do sistema.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_mensagem
      @mensagem = Mensagem.find(params[:id])


    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def mensagem_params
      params.require(:mensagem).permit(:texto, :remetente_id, :destinatario_id, :tipo_usuario, :lido, :objeto_id, :objeto_type)
    end
end
