class Administracao::RotasController < ApplicationController
  before_action :set_administracao_rota, only: [:show, :edit, :update, :destroy]

  # GET /administracao/rotas
  # GET /administracao/rotas.json
  def index
    @administracao_rotas = Administracao::Rota.all
  end

  # GET /administracao/rotas/1
  # GET /administracao/rotas/1.json
  def show
  end

  # GET /administracao/rotas/new
  def new
    @administracao_rota = Administracao::Rota.new
  end

  # GET /administracao/rotas/1/edit
  def edit
  end

  # POST /administracao/rotas
  # POST /administracao/rotas.json
  def create
    @administracao_rota = Administracao::Rota.new(administracao_rota_params)

    respond_to do |format|
      if @administracao_rota.save
        format.html { redirect_to @administracao_rota, notice: 'Rota was successfully created.' }
        format.json { render :show, status: :created, location: @administracao_rota }
      else
        format.html { render :new }
        format.json { render json: @administracao_rota.errors, status: :unprocessable_entity }
      end
    end
  end

  def tipo_destino 
   tipod = params[:tipod]
   
   case tipod 
    when 'Administracao::Departamento'
    @roteaveis = Administracao::Departamento.all.collect{|d|[d.nome,d.id]}
    when 'Administracao::Escola'
    @roteaveis = Administracao::Departamento.all.collect{|d|[d.nome,d.id]}
    when 'Administracao::Empresa'
    @roteaveis =   @empresas.collect {|e|[e.nome,e.id]}
    end

    render :partial=>"tipo_destino",:locals=>{:roteaveis=>@roteaveis}
   end

  # PATCH/PUT /administracao/rotas/1
  # PATCH/PUT /administracao/rotas/1.json
  def update
    respond_to do |format|
      if @administracao_rota.update(administracao_rota_params)
        format.html { redirect_to @administracao_rota, notice: 'Rota was successfully updated.' }
        format.json { render :show, status: :ok, location: @administracao_rota }
      else
        format.html { render :edit }
        format.json { render json: @administracao_rota.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /administracao/rotas/1
  # DELETE /administracao/rotas/1.json
  def destroy
    @administracao_rota.destroy
    respond_to do |format|
      format.html { redirect_to administracao_rotas_url, notice: 'Rota was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_administracao_rota
      @administracao_rota = Administracao::Rota.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def administracao_rota_params
      params.require(:administracao_rota).permit(:destino, :entidade_id, :tempo_previsto, :latitude, :longitude, :rota_longa, :intermunicipal,:roteavel_id,:roteavel_type)
    end
  end
