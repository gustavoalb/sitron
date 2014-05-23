class Administracao::CombustiveisController < ApplicationController
  before_action :set_administracao_combustivel, only: [:show, :edit, :update, :destroy]

  # GET /administracao/combustiveis
  # GET /administracao/combustiveis.json
  def index
    @administracao_combustiveis = Administracao::Combustivel.page params[:page]
  end

  # GET /administracao/combustiveis/1
  # GET /administracao/combustiveis/1.json
  def show
  end

  # GET /administracao/combustiveis/new
  def new
    @administracao_combustivel = Administracao::Combustivel.new
  end

  # GET /administracao/combustiveis/1/edit
  def edit
  end

  # POST /administracao/combustiveis
  # POST /administracao/combustiveis.json
  def create
    @administracao_combustivel = Administracao::Combustivel.new(administracao_combustivel_params)

    respond_to do |format|
      if @administracao_combustivel.save
        format.html { redirect_to @administracao_combustivel, notice: 'Combustivel was successfully created.' }
        format.json { render :show, status: :created, location: @administracao_combustivel }
      else
        format.html { render :new }
        format.json { render json: @administracao_combustivel.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /administracao/combustiveis/1
  # PATCH/PUT /administracao/combustiveis/1.json
  def update
    respond_to do |format|
      if @administracao_combustivel.update(administracao_combustivel_params)
        format.html { redirect_to @administracao_combustivel, notice: 'Combustivel was successfully updated.' }
        format.json { render :show, status: :ok, location: @administracao_combustivel }
      else
        format.html { render :edit }
        format.json { render json: @administracao_combustivel.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /administracao/combustiveis/1
  # DELETE /administracao/combustiveis/1.json
  def destroy
    @administracao_combustivel.destroy
    respond_to do |format|
      format.html { redirect_to administracao_combustiveis_url, notice: 'Combustivel was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_administracao_combustivel
      @administracao_combustivel = Administracao::Combustivel.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def administracao_combustivel_params
      params.require(:administracao_combustivel).permit(:nome, :valor)
    end
end
