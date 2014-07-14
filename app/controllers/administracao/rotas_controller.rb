class Administracao::RotasController < ApplicationController
  before_action :set_administracao_rota, only: [:show, :edit, :update, :destroy]
  before_action :load_rota, only: :create
  load_and_authorize_resource :class=>"Administracao::Rota", except: :create

  # GET /administracao/rotas
  # GET /administracao/rotas.json
  def index
    @administracao_rotas = Administracao::Rota.accessible_by(current_ability)
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
   tipod = params[:tipo_destino]
   
   case tipod 
    when 'Administracao::Departamento'
    @roteaveis = Administracao::Departamento.all
    when 'Administracao::Escola'
    @roteaveis = Administracao::Departamento.all
    when 'Administracao::Empresa'
    @roteaveis =   @empresas
    end

   # render :partial=>"tipo_destino",:locals=>{:roteaveis=>@roteaveis}

   response = []
    @roteaveis.each do |roteavel|
        response << {:id => roteavel.id, :n => roteavel.nome}
    end
    render :json => {:response => response.compact}.as_json
   end




   def destino 
    destino_id = params[:destino_id]
    classe = params[:classe] 
    @destino = classe.constantize.find(destino_id)

   # render :partial=>"mapa",:locals=>{:destino=>@destino}

   response = []
  
   response << {:latitude => @destino.endereco.latitude, :longitude => @destino.endereco.longitude}
   render :json => {:response => response.compact}.as_json
    
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

    def load_rota
      @administracao_rota = Administracao::Rota.new(administracao_rota_params)
    end
  end
