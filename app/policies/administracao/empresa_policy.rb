class Administracao::EmpresaPolicy
attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    @user.admin?
  end

  def update?
    @user.funcionario?
  end

  def destroy?
    @user.admin?
  end
end
