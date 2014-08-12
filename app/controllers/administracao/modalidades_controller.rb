# -*- encoding : utf-8 -*-
class Administracao::ModalidadesController < ApplicationController
  before_action :set_administracao_modalidade, only: [:show, :edit, :update, :destroy]
  before_action :load_modalidade, only: :create
  load_and_authorize_resource :class=>"Administracao::Modalidade", except: :create

  # GET /administracao/modalidades
  # GET /administracao/modalidades.json
  def index
    @administracao_modalidades = Administracao::Modalidade.accessible_by(current_ability)
  end

  # GET /administracao/modalidades/1
  # GET /administracao/modalidades/1.json
  def show
  end

  # GET /administracao/modalidades/new
  def new
    @administracao_modalidade = Administracao::Modalidade.new
  end

  # GET /administracao/modalidades/1/edit
  def edit
  end

  # POST /administracao/modalidades
  # POST /administracao/modalidades.json
  def create
    @administracao_modalidade = Administracao::Modalidade.new(administracao_modalidade_params)

    respond_to do |format|
      if @administracao_modalidade.save
        format.html { redirect_to @administracao_modalidade, notice: 'Modalidade foi criado com sucesso.' }
        format.json { render :show, status: :created, location: @administracao_modalidade }
      else
        format.html { render :new }
        format.json { render json: @administracao_modalidade.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /administracao/modalidades/1
  # PATCH/PUT /administracao/modalidades/1.json
  def update
    respond_to do |format|
      if @administracao_modalidade.update(administracao_modalidade_params)
        format.html { redirect_to @administracao_modalidade, notice: 'Modalidade foi atualizado com sucesso.' }
        format.json { render :show, status: :ok, location: @administracao_modalidade }
      else
        format.html { render :edit }
        format.json { render json: @administracao_modalidade.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /administracao/modalidades/1
  # DELETE /administracao/modalidades/1.json
  def destroy
    @administracao_modalidade.destroy
    respond_to do |format|
      format.html { redirect_to administracao_modalidades_url, notice: 'Modalidade foi removido do sistema.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_administracao_modalidade
      @administracao_modalidade = Administracao::Modalidade.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def administracao_modalidade_params
      params.require(:administracao_modalidade).permit(:nome, :periodo_diario, :dias_mes, :com_motorista, :com_combustivel, :quilometragem_livre, :mes_completo)
    end

    def load_modalidade
      @administracao_modalidade = Administracao::Modalidade.new(administracao_modalidade_params)
    end
end
