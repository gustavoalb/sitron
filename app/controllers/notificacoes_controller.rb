class NotificacoesController < ApplicationController
  before_action :set_notificacao, only: [:show, :edit, :update, :destroy]

  # GET /notificacoes
  # GET /notificacoes.json
  def index
    @notificacoes = Notificacao.all
  end

  # GET /notificacoes/1
  # GET /notificacoes/1.json
  def show
  end

  # GET /notificacoes/new
  def new
    @notificacao = Notificacao.new
  end

  # GET /notificacoes/1/edit
  def edit
  end

  # POST /notificacoes
  # POST /notificacoes.json
  def create
    @notificacao = Notificacao.new(notificacao_params)

    respond_to do |format|
      if @notificacao.save
        format.html { redirect_to @notificacao, notice: 'Notificacao was successfully created.' }
        format.json { render :show, status: :created, location: @notificacao }
      else
        format.html { render :new }
        format.json { render json: @notificacao.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /notificacoes/1
  # PATCH/PUT /notificacoes/1.json
  def update
    respond_to do |format|
      if @notificacao.update(notificacao_params)
        format.html { redirect_to @notificacao, notice: 'Notificacao was successfully updated.' }
        format.json { render :show, status: :ok, location: @notificacao }
      else
        format.html { render :edit }
        format.json { render json: @notificacao.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /notificacoes/1
  # DELETE /notificacoes/1.json
  def destroy
    @notificacao.destroy
    respond_to do |format|
      format.html { redirect_to notificacoes_url, notice: 'Notificacao was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_notificacao
      @notificacao = Notificacao.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def notificacao_params
      params.require(:notificacao).permit(:texto, :motivo, :state, :origem_id, :entidade_id, :posto_id)
    end
end
