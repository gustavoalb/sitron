# -*- encoding : utf-8 -*-
class Ability
  include CanCan::Ability
  def initialize(user)
    if user.administrador?
      can :manage, :all
    end

    if user.useget?
      can [:read,:update], User, {:id=>user.id}
      can :manage, Requisicao, {:requisitante_id=>user.pessoa.id}
      can [:index,:definir_posto,:detalhes_requisicao,:cancelar_requisicao,:cancelar_confirmada],Requisicao
      can :manage, Administracao::Patio
      can :manage, Administracao::Pessoa, {:departamento_id=>user.pessoa.departamento_id}

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
