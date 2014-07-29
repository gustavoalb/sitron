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
      can [:read,:update], User, {:id=>user.id}
      can :manage, Requisicao, {:requisitante_id=>user.pessoa.id}
      cannot :manage, :requisicao_imediata, Requisicao
      can :manage, Administracao::Pessoa, {:departamento_id=>user.pessoa.departamento_id}
      cannot [:gerencia_index,:definir_posto,:detalhes_requisicao,:cancelar_requisicao],Requisicao
    end


  end
end
