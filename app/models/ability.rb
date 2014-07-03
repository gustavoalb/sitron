class Ability
  include CanCan::Ability
  def initialize(user)
    if user.administrador?
      can :manage, :all
    end

    if user.useget?
      can :manage, :all
      cannot :manage, :requisicao_imediata, Requisicao
    end

    if user.coordenador?
      can :manage, User, {:id=>user.id}
      can :manage, Requisicao, {:requisitante_id=>user.id}
      cannot :manage, :requisicao_imediata, Requisicao
      can :manage, Administracao::Pessoa, {:departamento_id=>user.pessoa.departamento_id}
    end
  end
end
