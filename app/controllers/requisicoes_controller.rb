class RequisicoesController < ApplicationController
  before_action :set_requisicao, only: [:show, :edit, :update, :destroy]

  # GET /requisicoes
  # GET /requisicoes.json
  add_breadcrumb "Requisições de Transporte"
  def index
    @requisicoes = Requisicao.all
  end

  # GET /requisicoes/1
  # GET /requisicoes/1.json
  def show
  end

  # GET /requisicoes/new
  def new
    @requisicao = Requisicao.new
    @pessoas = Administracao::Pessoa.all
  end


  def agendar
    @requisicao = Requisicao.new
    @pessoas = Administracao::Pessoa.all
  end


  # GET /requisicoes/1/edit
  def edit
  end

  # POST /requisicoes
  # POST /requisicoes.json
  def agendar_requisicao

    @requisicao = Requisicao.new(requisicao_params)
    @requisicao.data_ida = @requisicao.inicio.to_date #if params[requisicao_params[:inicio]]
    @requisicao.hora_ida = @requisicao.inicio.to_time #if params[requisicao_params[:inicio]]
    @requisicao.periodo_longo = true
    
    respond_to do |format|
      if @requisicao.save!
        @requisicao.agendar
        format.html { redirect_to @requisicao, notice: 'A Requisição foi agendada com sucesso.' }
        format.json { render :show, status: :created, location: @requisicao }
      else
        @pessoas = Administracao::Pessoa.all
        format.html { render :agendar }
        format.json { render json: @requisicao.errors, status: :unprocessable_entity }
      end
    end
  end

    def create
    @requisicao = Requisicao.new(requisicao_params)
    date_and_time = '%m-%d-%Y %H:%M:%S %Z'
    data = Time.zone.parse("#{requisicao_params[:data_ida].gsub('/','-')} #{requisicao_params[:hora_ida]}")

    #data = DateTime.strptime("#{requisicao_params[:data_ida].gsub('/','-')} #{requisicao_params[:hora_ida]} Brasilia",date_and_time)
    @requisicao.inicio = data

    respond_to do |format|
      if @requisicao.save!
        format.html { redirect_to @requisicao, notice: 'A Requisicao foi Criada com Sucesso' }
        format.json { render :show, status: :created, location: @requisicao }
      else
        @pessoas = Administracao::Pessoa.all
        format.html { render :new }
        format.json { render json: @requisicao.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /requisicoes/1
  # PATCH/PUT /requisicoes/1.json
  def update
    respond_to do |format|
      if @requisicao.update(requisicao_params)
        format.html { redirect_to @requisicao, notice: 'Requisicao was successfully updated.' }
        format.json { render :show, status: :ok, location: @requisicao }
      else
        format.html { render :edit }
        format.json { render json: @requisicao.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /requisicoes/1
  # DELETE /requisicoes/1.json
  def destroy
    @requisicao.destroy
    respond_to do |format|
      format.html { redirect_to requisicoes_url, notice: 'Requisicao was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_requisicao
      @requisicao = Requisicao.find(params[:id])
    end
    
    # Never trust parameters from the scary internet, only allow the white list through.
    def requisicao_params
      params.require(:requisicao).permit(:numero, :motivo, :descricao, :requisitante_id, :data_ida, :hora_ida, :periodo, :periodo_longo, :inicio, :fim, :posto_id, :preferencia_id,:rota_ids=>[],:pessoa_ids=>[])
    end
end
