# -*- encoding : utf-8 -*-
class ApplicationController < ActionController::Base
  include Pundit
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :initialize_variaveis
  add_breadcrumb("Início",nil,:icon=>"dashboard")

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :name
    devise_parameter_sanitizer.for(:account_update) << :name
  end


  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    flash[:alert] = "Access denied."
    redirect_to (request.referrer || root_path)
  end


  def initialize_variaveis
      @estados = Estado.all.collect{|e|[e.nome,e.id]}
      @empresas = Administracao::Empresa.all     
  end

end
