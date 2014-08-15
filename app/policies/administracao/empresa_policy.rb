# -*- encoding : utf-8 -*-
class Administracao::EmpresaPolicy
attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    @user.administrador?
  end

  def update?
    @user.funcionario?
  end

  def destroy?
    @user.administrador?
  end
end
