# -*- encoding : utf-8 -*-
class Administracao::VeiculosController < ApplicationController
  before_action :set_administracao_veiculo, only: [:show, :edit, :update, :destroy]

  # GET /administracao/veiculos
  # GET /administracao/veiculos.json
  def index
    @administracao_veiculos = Administracao::Veiculo.all
  end

  # GET /administracao/veiculos/1
  # GET /administracao/veiculos/1.json
  def show
  end

  # GET /administracao/veiculos/new
  def new
    @administracao_veiculo = Administracao::Veiculo.new
  end

  # GET /administracao/veiculos/1/edit
  def edit
  end

  # POST /administracao/veiculos
  # POST /administracao/veiculos.json
  def create
    @administracao_veiculo = Administracao::Veiculo.new(administracao_veiculo_params)

    respond_to do |format|
      if @administracao_veiculo.save
        format.html { redirect_to @administracao_veiculo, notice: 'Veiculo was successfully created.' }
        format.json { render :show, status: :created, location: @administracao_veiculo }
      else
        format.html { render :new }
        format.json { render json: @administracao_veiculo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /administracao/veiculos/1
  # PATCH/PUT /administracao/veiculos/1.json
  def update
    respond_to do |format|
      if @administracao_veiculo.update(administracao_veiculo_params)
        format.html { redirect_to @administracao_veiculo, notice: 'Veiculo was successfully updated.' }
        format.json { render :show, status: :ok, location: @administracao_veiculo }
      else
        format.html { render :edit }
        format.json { render json: @administracao_veiculo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /administracao/veiculos/1
  # DELETE /administracao/veiculos/1.json
  def destroy
    @administracao_veiculo.destroy
    respond_to do |format|
      format.html { redirect_to administracao_veiculos_url, notice: 'Veiculo was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_administracao_veiculo
      @administracao_veiculo = Administracao::Veiculo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def administracao_veiculo_params
      params.require(:administracao_veiculo).permit(:placa,:tipo, :motor, :direcao, :marca, :modelo, :capacidade_carga, :capacidade_passageiros, :ano_fabricacao, :ano_modelo, :intens_obrigatorios, :observacao, :modalidade_id, :combustivel_id, :turno_id,:empresa_id,:qrcode)
    end
end
