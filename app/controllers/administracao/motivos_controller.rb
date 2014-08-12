class Administracao::MotivosController < ApplicationController
  before_action :set_administracao_motivo, only: [:show, :edit, :update, :destroy]
  before_action :load_motivo, only: :create
  load_and_authorize_resource :class=>"Administracao::Motivo", except: :create
  # GET /administracao/motivos
  # GET /administracao/motivos.json
  def index
    @administracao_motivos = Administracao::Motivo.accessible_by(current_ability)
  end

  # GET /administracao/motivos/1
  # GET /administracao/motivos/1.json
  def show
  end

  # GET /administracao/motivos/new
  def new
    @administracao_motivo = Administracao::Motivo.new
  end

  # GET /administracao/motivos/1/edit
  def edit
  end

  # POST /administracao/motivos
  # POST /administracao/motivos.json
  def create
    @administracao_motivo = Administracao::Motivo.new(administracao_motivo_params)

    respond_to do |format|
      if @administracao_motivo.save
        format.html { redirect_to @administracao_motivo, notice: 'Motivo foi criado com sucesso.' }
        format.json { render :show, status: :created, location: @administracao_motivo }
      else
        format.html { render :new }
        format.json { render json: @administracao_motivo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /administracao/motivos/1
  # PATCH/PUT /administracao/motivos/1.json
  def update
    respond_to do |format|
      if @administracao_motivo.update(administracao_motivo_params)
        format.html { redirect_to @administracao_motivo, notice: 'Motivo foi atualizado com sucesso.' }
        format.json { render :show, status: :ok, location: @administracao_motivo }
      else
        format.html { render :edit }
        format.json { render json: @administracao_motivo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /administracao/motivos/1
  # DELETE /administracao/motivos/1.json
  def destroy
    @administracao_motivo.destroy
    respond_to do |format|
      format.html { redirect_to administracao_motivos_url, notice: 'Motivo foi removido do sistema.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_administracao_motivo
      @administracao_motivo = Administracao::Motivo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def administracao_motivo_params
      params.require(:administracao_motivo).permit(:nome, :tipo_id, :carga, :passageiro, :entrega_documento, :interior, :viagem_longa,:urgente,:necessita_descricao)
    end

    def load_motivo
      @administracao_motivo = Administracao::Motivo.new(administracao_motivo_params)
    end

end
