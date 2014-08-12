# -*- encoding : utf-8 -*-
class Administracao::ConfiguracoesController < ApplicationController
  before_action :set_administracao_configuracao, only: [:show, :edit, :update, :destroy]
  before_action :load_configuracao, only: :create
  load_and_authorize_resource :class=>"Administracao::Configuracao", except: :create

  # GET /administracao/configuracoes
  # GET /administracao/configuracoes.json
  def index
    @administracao_configuracoes = Administracao::Configuracao.accessible_by(current_ability)
  end

  # GET /administracao/configuracoes/1
  # GET /administracao/configuracoes/1.json
  def show
  end

  # GET /administracao/configuracoes/new
  def new
    @administracao_configuracao = Administracao::Configuracao.new
  end

  # GET /administracao/configuracoes/1/edit
  def edit
  end

  # POST /administracao/configuracoes
  # POST /administracao/configuracoes.json
  def create
    @administracao_configuracao = Administracao::Configuracao.new(administracao_configuracao_params)

    respond_to do |format|
      if @administracao_configuracao.save
        format.html { redirect_to @administracao_configuracao, notice: 'Configuracao foi criado com sucesso.' }
        format.json { render :show, status: :created, location: @administracao_configuracao }
      else
        format.html { render :new }
        format.json { render json: @administracao_configuracao.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /administracao/configuracoes/1
  # PATCH/PUT /administracao/configuracoes/1.json
  def update
    respond_to do |format|
      if @administracao_configuracao.update(administracao_configuracao_params)
        format.html { redirect_to @administracao_configuracao, notice: 'Configuracao foi atualizado com sucesso.' }
        format.json { render :show, status: :ok, location: @administracao_configuracao }
      else
        format.html { render :edit }
        format.json { render json: @administracao_configuracao.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /administracao/configuracoes/1
  # DELETE /administracao/configuracoes/1.json
  def destroy
    @administracao_configuracao.destroy
    respond_to do |format|
      format.html { redirect_to administracao_configuracoes_url, notice: 'Configuracao foi removido do sistema.' }
      format.json { head :no_content }
    end
  end

  def salvar_skin

    @configuracao  = current_user.configuracao || current_user.build_configuracao
    @configuracao.skin = params[:skin]
    @configuracao.save!


   render :nothing => true
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_administracao_configuracao
      @administracao_configuracao = Administracao::Configuracao.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def administracao_configuracao_params
      params.require(:administracao_configuracao).permit(:skin,:user_id)
    end

    def load_configuracao
      @administracao_configuracao = Administracao::Configuracao.new(administracao_configuracao_params )
    end
end
