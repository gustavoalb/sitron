# -*- encoding : utf-8 -*-
class UserPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    @user.administrador?
  end

  def update?
    @user.administrador?
  end

  def destroy?
    @user.administrador?
  end

end
