# -*- encoding : utf-8 -*-
class Administracao::PessoasController < ApplicationController
  before_action :set_administracao_pessoa, only: [:show, :edit, :update, :destroy]
  before_action :load_pessoa, only: :create
  load_and_authorize_resource :class=>"Administracao::Pessoa", except: :create

  # GET /administracao/pessoas
  # GET /administracao/pessoas.json
  def index
    @administracao_pessoas = Administracao::Pessoa.accessible_by(current_ability)
  end

  # GET /administracao/pessoas/1
  # GET /administracao/pessoas/1.json
  def show
  end

  # GET /administracao/pessoas/new
  def new
    @administracao_pessoa = Administracao::Pessoa.new
  end

  # GET /administracao/pessoas/1/edit
  def edit
  end

  def listar_departamentos
   @entidade = Administracao::Empresa.find(params[:empresa_id])
   @departamentos = @entidade.departamentos

   render :partial=> "departamentos",:locals=>{:departamentos=>@departamentos}
  end

  # POST /administracao/pessoas
  # POST /administracao/pessoas.json
  def create
    @administracao_pessoa = Administracao::Pessoa.new(administracao_pessoa_params)

    respond_to do |format|
      if @administracao_pessoa.save
        format.html { redirect_to @administracao_pessoa, notice: 'Pessoa foi criado com sucesso.' }
        format.json { render :show, status: :created, location: @administracao_pessoa }
      else
        format.html { render :new }
        format.json { render json: @administracao_pessoa.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /administracao/pessoas/1
  # PATCH/PUT /administracao/pessoas/1.json
  def update
    respond_to do |format|
      if @administracao_pessoa.update(administracao_pessoa_params)
        format.html { redirect_to @administracao_pessoa, notice: 'Pessoa foi atualizado com sucesso.' }
        format.json { render :show, status: :ok, location: @administracao_pessoa }
      else
        format.html { render :edit }
        format.json { render json: @administracao_pessoa.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /administracao/pessoas/1
  # DELETE /administracao/pessoas/1.json
  def destroy
    @administracao_pessoa.destroy
    respond_to do |format|
      format.html { redirect_to administracao_pessoas_url, notice: 'Pessoa foi removido do sistema.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_administracao_pessoa
      @administracao_pessoa = Administracao::Pessoa.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def administracao_pessoa_params
      params.require(:administracao_pessoa).permit(:nome, :cpf, :email, :matricula, :cargo_id,:departamento_id,:empresa_id,:visivel)
    end

    def load_pessoa
    @pessoa = Administracao::Pessoa.new(administracao_pessoa_params)
  end
end
