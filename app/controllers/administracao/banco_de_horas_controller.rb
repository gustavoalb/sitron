# -*- encoding : utf-8 -*-
class Administracao::BancoDeHorasController < ApplicationController
  before_action :set_administracao_banco_de_hora, only: [:show, :edit, :update, :destroy]

  # GET /administracao/banco_de_horas
  # GET /administracao/banco_de_horas.json
  def index
    @administracao_banco_de_horas = Administracao::BancoDeHora.all
  end

  # GET /administracao/banco_de_horas/1
  # GET /administracao/banco_de_horas/1.json
  def show
  end

  # GET /administracao/banco_de_horas/new
  def new
    @administracao_banco_de_hora = Administracao::BancoDeHora.new
  end

  # GET /administracao/banco_de_horas/1/edit
  def edit
  end

  # POST /administracao/banco_de_horas
  # POST /administracao/banco_de_horas.json
  def create
    @administracao_banco_de_hora = Administracao::BancoDeHora.new(administracao_banco_de_hora_params)

    respond_to do |format|
      if @administracao_banco_de_hora.save
        format.html { redirect_to @administracao_banco_de_hora, notice: 'Banco de hora foi criado com sucesso.' }
        format.json { render :show, status: :created, location: @administracao_banco_de_hora }
      else
        format.html { render :new }
        format.json { render json: @administracao_banco_de_hora.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /administracao/banco_de_horas/1
  # PATCH/PUT /administracao/banco_de_horas/1.json
  def update
    respond_to do |format|
      if @administracao_banco_de_hora.update(administracao_banco_de_hora_params)
        format.html { redirect_to @administracao_banco_de_hora, notice: 'Banco de hora foi atualizado com sucesso.' }
        format.json { render :show, status: :ok, location: @administracao_banco_de_hora }
      else
        format.html { render :edit }
        format.json { render json: @administracao_banco_de_hora.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /administracao/banco_de_horas/1
  # DELETE /administracao/banco_de_horas/1.json
  def destroy
    @administracao_banco_de_hora.destroy
    respond_to do |format|
      format.html { redirect_to administracao_banco_de_horas_url, notice: 'Banco de hora foi removido do sistema.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_administracao_banco_de_hora
      @administracao_banco_de_hora = Administracao::BancoDeHora.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def administracao_banco_de_hora_params
      params.require(:administracao_banco_de_hora).permit(:posto_id, :dia, :mes, :ano, :horas_normais, :horas_extras, :numero_semana, :inicio_semana, :fim_semana)
    end
end
