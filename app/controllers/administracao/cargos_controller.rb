class Administracao::CargosController < ApplicationController
  before_action :set_administracao_cargo, only: [:show, :edit, :update, :destroy]
  before_action :load_cargo, only: :create
  before_action do  
    resource = controller_name.singularize.to_sym
    method = "#{resource}_params"
    params[resource] &&= send(method) if respond_to?(method, true)
  end   
  load_and_authorize_resource :class=>"Administracao::Cargo", except: :create

  # GET /administracao/cargos
  # GET /administracao/cargos.json
  def index
    @administracao_cargos = Administracao::Cargo.accessible_by(current_ability)
  end

  # GET /administracao/cargos/1
  # GET /administracao/cargos/1.json
  def show
  end

  # GET /administracao/cargos/new
  def new
    @administracao_cargo = Administracao::Cargo.new
  end

  # GET /administracao/cargos/1/edit
  def edit
  end

  # POST /administracao/cargos
  # POST /administracao/cargos.json
  def create
    @administracao_cargo = Administracao::Cargo.new(administracao_cargo_params)

    respond_to do |format|
      if @administracao_cargo.save
        format.html { redirect_to @administracao_cargo, notice: 'Cargo foi criado com sucesso.' }
        format.json { render :show, status: :created, location: @administracao_cargo }
      else
        format.html { render :new }
        format.json { render json: @administracao_cargo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /administracao/cargos/1
  # PATCH/PUT /administracao/cargos/1.json
  def update
    respond_to do |format|
      if @administracao_cargo.update(administracao_cargo_params)
        format.html { redirect_to @administracao_cargo, notice: 'Cargo foi atualizado com sucesso.' }
        format.json { render :show, status: :ok, location: @administracao_cargo }
      else
        format.html { render :edit }
        format.json { render json: @administracao_cargo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /administracao/cargos/1
  # DELETE /administracao/cargos/1.json
  def destroy
    @administracao_cargo.destroy
    respond_to do |format|
      format.html { redirect_to administracao_cargos_url, notice: 'Cargo foi removido do sistema.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_administracao_cargo
      @administracao_cargo = Administracao::Cargo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def administracao_cargo_params
      params.require(:administracao_cargo).permit(:nome, :entidade_id)
    end

    def load_cargo
      @administracao_cargo = Administracao::Cargo.new(administracao_cargo_params)
    end

end
