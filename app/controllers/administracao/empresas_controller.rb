# -*- encoding : utf-8 -*-
class Administracao::EmpresasController < ApplicationController
  before_action :set_administracao_empresa, only: [:show, :edit, :update, :destroy]

  # GET /administracao/empresas
  # GET /administracao/empresas.json
  def index
    @administracao_empresas = Administracao::Empresa.page params[:page]
  end

  # GET /administracao/empresas/1
  # GET /administracao/empresas/1.json
  def show
  end

  # GET /administracao/empresas/new
  def new
    @administracao_empresa = Administracao::Empresa.new
    @endereco = @administracao_empresa.build_endereco
  end

  # GET /administracao/empresas/1/edit
  def edit
  end

  # POST /administracao/empresas
  # POST /administracao/empresas.json
  def create
    @administracao_empresa = Administracao::Empresa.new(administracao_empresa_params)

    respond_to do |format|
      if @administracao_empresa.save
        format.html { redirect_to @administracao_empresa, notice: 'Empresa was successfully created.' }
        format.json { render :show, status: :created, location: @administracao_empresa }
      else
        @endereco = @administracao_empresa.build_endereco
        format.html { render :new }
        format.json { render json: @administracao_empresa.errors, status: :unprocessable_entity }
      end
    end
  end


    def listar_cidades
    @estado = Estado.find(params[:estado_id])
    @cidades = @estado.cidades.all.collect{|c|[c.nome,c.id]}
    render :partial=>"cidades",:locals=>{:endereco=>@endereco,:cidades=>@cidades}
  end



  def listar_bairros
    @cidade = Cidade.find(params[:cidade_id])
    @bairros = @cidade.bairros.all.collect{|b|[b.nome,b.id]}

    render :partial=>"bairros",:locals=>{:bairros=>@bairros}
  end

  # PATCH/PUT /administracao/empresas/1
  # PATCH/PUT /administracao/empresas/1.json
  def update
    respond_to do |format|
      if @administracao_empresa.update(administracao_empresa_params)
        format.html { redirect_to @administracao_empresa, notice: 'Empresa was successfully updated.' }
        format.json { render :show, status: :ok, location: @administracao_empresa }
      else
        format.html { render :edit }
        format.json { render json: @administracao_empresa.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /administracao/empresas/1
  # DELETE /administracao/empresas/1.json
  def destroy
    @administracao_empresa.destroy
    respond_to do |format|
      format.html { redirect_to administracao_empresas_url, notice: 'Empresa was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_administracao_empresa
      @administracao_empresa = Administracao::Empresa.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def administracao_empresa_params
      params.require(:administracao_empresa).permit(:nome, :cnpj, :responsavel_id,endereco_attributes: [:logradouro,:numero,:complemento,:estado_id,:cidade_id,:bairro_id,:cep])
    end
end
