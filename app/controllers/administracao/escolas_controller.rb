class Administracao::EscolasController < ApplicationController
  before_action :set_administracao_escola, only: [:show, :edit, :update, :destroy]

  # GET /administracao/escolas
  # GET /administracao/escolas.json
  def index
    @administracao_escolas = Administracao::Escola.all
  end

  # GET /administracao/escolas/1
  # GET /administracao/escolas/1.json
  def show
  end

  # GET /administracao/escolas/new
  def new
    @administracao_escola = Administracao::Escola.new
  end

  # GET /administracao/escolas/1/edit
  def edit
  end

  # POST /administracao/escolas
  # POST /administracao/escolas.json
  def create
    @administracao_escola = Administracao::Escola.new(administracao_escola_params)

    respond_to do |format|
      if @administracao_escola.save
        format.html { redirect_to @administracao_escola, notice: 'Escola foi criado com sucesso.' }
        format.json { render :show, status: :created, location: @administracao_escola }
      else
        format.html { render :new }
        format.json { render json: @administracao_escola.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /administracao/escolas/1
  # PATCH/PUT /administracao/escolas/1.json
  def update
    respond_to do |format|
      if @administracao_escola.update(administracao_escola_params)
        format.html { redirect_to @administracao_escola, notice: 'Escola foi atualizado com sucesso.' }
        format.json { render :show, status: :ok, location: @administracao_escola }
      else
        format.html { render :edit }
        format.json { render json: @administracao_escola.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /administracao/escolas/1
  # DELETE /administracao/escolas/1.json
  def destroy
    @administracao_escola.destroy
    respond_to do |format|
      format.html { redirect_to administracao_escolas_url, notice: 'Escola foi removido do sistema.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_administracao_escola
      @administracao_escola = Administracao::Escola.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def administracao_escola_params
      params.require(:administracao_escola).permit(:municipio_id, :dependencia_administrativa, :zona, :codigo, :nome, :telefone)
    end
end
