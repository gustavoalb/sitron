class Administracao::RelatoriosDiariosController < ApplicationController
  before_action :set_administracao_relatorios_diario, only: [:show, :edit, :update, :destroy]

  # GET /administracao/relatorios_diarios
  # GET /administracao/relatorios_diarios.json
  def index
    @administracao_relatorios_diarios = Administracao::RelatoriosDiario.all
  end

  # GET /administracao/relatorios_diarios/1
  # GET /administracao/relatorios_diarios/1.json
  def show
  end

  # GET /administracao/relatorios_diarios/new
  def new
    @administracao_relatorios_diario = Administracao::RelatoriosDiario.new
  end

  # GET /administracao/relatorios_diarios/1/edit
  def edit
  end

  # POST /administracao/relatorios_diarios
  # POST /administracao/relatorios_diarios.json
  def create
    @administracao_relatorios_diario = Administracao::RelatoriosDiario.new(administracao_relatorios_diario_params)

    respond_to do |format|
      if @administracao_relatorios_diario.save
        format.html { redirect_to @administracao_relatorios_diario, notice: 'Relatorios diario was successfully created.' }
        format.json { render :show, status: :created, location: @administracao_relatorios_diario }
      else
        format.html { render :new }
        format.json { render json: @administracao_relatorios_diario.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /administracao/relatorios_diarios/1
  # PATCH/PUT /administracao/relatorios_diarios/1.json
  def update
    respond_to do |format|
      if @administracao_relatorios_diario.update(administracao_relatorios_diario_params)
        format.html { redirect_to @administracao_relatorios_diario, notice: 'Relatorios diario was successfully updated.' }
        format.json { render :show, status: :ok, location: @administracao_relatorios_diario }
      else
        format.html { render :edit }
        format.json { render json: @administracao_relatorios_diario.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /administracao/relatorios_diarios/1
  # DELETE /administracao/relatorios_diarios/1.json
  def destroy
    @administracao_relatorios_diario.destroy
    respond_to do |format|
      format.html { redirect_to administracao_relatorios_diarios_url, notice: 'Relatorios diario was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_administracao_relatorios_diario
      @administracao_relatorios_diario = Administracao::RelatoriosDiario.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def administracao_relatorios_diario_params
      params.require(:administracao_relatorios_diario).permit(:tipo, :descricao, :data)
    end
end
