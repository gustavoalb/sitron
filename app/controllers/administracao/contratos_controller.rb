class Administracao::ContratosController < ApplicationController
  before_action :set_administracao_contrato, only: [:show, :edit, :update, :destroy]
  before_action :load_contrato, only: :create
  load_and_authorize_resource :class=>"Administracao::Contrato", except: :create

  # GET /administracao/contratos
  # GET /administracao/contratos.json
  def index
    @administracao_contratos = Administracao::Contrato.accessible_by(current_ability)
  end

  # GET /administracao/contratos/1
  # GET /administracao/contratos/1.json
  def show
  end

  # GET /administracao/contratos/new
  def new
    @administracao_contrato = Administracao::Contrato.new
  end

  # GET /administracao/contratos/1/edit
  def edit
  end

  # POST /administracao/contratos
  # POST /administracao/contratos.json
  def create
    @administracao_contrato = Administracao::Contrato.new(administracao_contrato_params)

    respond_to do |format|
      if @administracao_contrato.save
        format.html { redirect_to @administracao_contrato, notice: 'Contrato was successfully created.' }
        format.json { render :show, status: :created, location: @administracao_contrato }
      else
        format.html { render :new }
        format.json { render json: @administracao_contrato.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /administracao/contratos/1
  # PATCH/PUT /administracao/contratos/1.json
  def update
    respond_to do |format|
      if @administracao_contrato.update(administracao_contrato_params)
        format.html { redirect_to @administracao_contrato, notice: 'Contrato was successfully updated.' }
        format.json { render :show, status: :ok, location: @administracao_contrato }
      else
        format.html { render :edit }
        format.json { render json: @administracao_contrato.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /administracao/contratos/1
  # DELETE /administracao/contratos/1.json
  def destroy
    @administracao_contrato.destroy
    respond_to do |format|
      format.html { redirect_to administracao_contratos_url, notice: 'Contrato was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_administracao_contrato
      @administracao_contrato = Administracao::Contrato.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def administracao_contrato_params
      params.require(:administracao_contrato).permit(:numero, :empresa_id, :lei, :artigo,:inicio_vigencia,:fim_vigencia)
    end

    def load_contrato
      @administracao_contrato = Administracao::Contrato.new(administracao_contrato_params)
    end
end
