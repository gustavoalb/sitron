# -*- encoding : utf-8 -*-
class ApplicationController < ActionController::Base
  include Pundit
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!
  before_action :initialize_variaveis
  before_action :mensagens
  

  


  add_breadcrumb("Início",nil,:icon=>"dashboard")



  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :name
    devise_parameter_sanitizer.for(:account_update) << :name
  end


  rescue_from CanCan::AccessDenied do |exception|
    redirect_to main_app.home_nao_autorizado_url
  end

  private

  def user_not_authorized
    flash[:alert] = "Você não tem acesso à esta área."
    redirect_to (request.referrer || root_path)
  end


  def initialize_variaveis
    @estados = Estado.all.order(:nome).collect{|e|[e.nome,e.id]}
    @empresas = Administracao::Empresa.all.order(:nome)    
    @modalidades = Administracao::Modalidade.all.order(:nome) 
    @combustiveis = Administracao::Combustivel.all.order(:nome)
    @rotas = Administracao::Rota.all.order(:destino)
    @problemas = Avaliacao.where(:tipo=>2).all
    @cargos = Administracao::Cargo.all.order(:nome)
    @departamentos = Administracao::Departamento.all.order(:nome)

  end

  def mensagens
    @mensagensb = Mensagem.para_o_usuario(current_user).nao_lidas if current_user
    #@notificacoesb = Notificacao.nao_vista.all if current_user and current_user.administrador?
    @notificacoes_gerentes = Notificacao.nao_vista.para_gerentes.all if current_user and (current_user.useget? or current_user.administrador?)
    @notificacoes_usuarios = Notificacao.nao_vista.do_usuario(current_user).all if current_user
    
    if current_user and (current_user.useget? or current_user.administrador?)
      @notificacoesb = @notificacoes_gerentes + @notificacoes_usuarios
    else
      @notificacoesb = @notificacoes_usuarios
    end
  end

end
