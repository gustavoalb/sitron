# -*- encoding : utf-8 -*-
class UsuariosController < ApplicationController
  before_action :load_user, only: :create
  load_and_authorize_resource :class=>"User", except: :create
  # GET /usuarios
  # GET /usuarios.json
  def index
    @usuarios = User.accessible_by(current_ability)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @usuarios }
    end
  end

  # GET /usuarios/1
  # GET /usuarios/1.json
  def show
    @usuario = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @usuario }
    end
  end

  def listar_departamentos
   @entidade = Administracao::Empresa.find(params[:empresa_id])
   @departamentos = @entidade.departamentos.order(:nome)

   render :partial=> "departamentos",:locals=>{:departamentos=>@departamentos}
 end

  # GET /usuarios/new
  # GET /usuarios/new.json
  def new
    @usuario = User.new
    @pessoa = @usuario.build_pessoa

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @usuario }
    end
  end

  # GET /usuarios/1/edit
  def edit
    @usuario = User.find(params[:id])
    @pessoa = @usuario.pessoa
    @entidade = Administracao::Empresa.find(@pessoa.entidade_id) if @pessoa.entidade_id
    if @entidade
      @departamentos = @entidade.departamentos.collect{|d|[d.nome,d.id]}
      @cargos = @entidade.cargos.collect{|c|[c.nome,c.id]}
    else
      @departamentos = ["Selecione a Entidade!",0]
      @cargos = ["Selecione a Entidade",0]
    end
  end

  # POST /usuarios
  # POST /usuarios.json
  def create
  	@usuario = User.new(user_params)

    respond_to do |format|
      if @usuario.save!
        flash[:notice] = "Usuario criado com sucesso"
        format.html { redirect_to usuarios_url }
        format.json { render json: @usuario, status: :created, location: @usuario }
      else
      	@pessoa = @usuario.build_pessoa(user_params[:pessoa_attributes])
        flash[:error] = "Erro ao criar o usuario"
        format.html { render action: "new" }
        format.json { render json: @usuario.errors, status: :unprocessable_entity }
        
      end
    end
  end

  # PUT /usuarios/1
  # PUT /usuarios/1.json
  def update
    @usuario = User.find(params[:id])

    respond_to do |format|
      if @usuario.update_attributes(user_params)
        flash[:notice] = "Usuario atualizado com sucesso"
        format.html { redirect_to usuarios_url }
        format.json { head :no_content }
      else
      	@pessoa = @usuario.pessoa
        flash[:error] = "Erro ao atualizar o usuario"
        format.html { render action: "edit" }
        format.json { render json: @usuario.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /usuarios/1
  # DELETE /usuarios/1.json
  def destroy
    @usuario = User.find(params[:id])
    @usuario.destroy

    respond_to do |format|
     format.html { redirect_to usuarios_url }
     format.json { head :no_content }
   end
  end

  def redefinir_senha
    @usuario = User.find(params[:usuario_id])
    @usuario.password = @usuario.password_confirmation = "@sitron2015"
    if @usuario.save(:validate=>false)
      redirect_to usuarios_url, notice: 'Senha redefinida com sucesso. Nova Senha = @sitron2015'
    else
      redirect_to usuarios_url, alert: 'Senha não foi redefinida, favor checar o cadastro.'
    end
  end

 private
  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:email,
    	:role, :password, :password_confirmation, :avatar,pessoa_attributes: [:id, :nome, :cpf, :email, :matricula, :cargo_id, :departamento_id, :entidade_id]) 
  end

  def load_user
    @usuario = User.new(user_params)
  end
    
    
end
