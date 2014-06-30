class Ability
  include CanCan::Ability
  def initialize(user)
    if user.admin?
      can :manage, :all
      #can [:read,:update],Pessoa,{:id=>user.pessoa_id}
    end

    if user.useget?
      can :manage, :all
      #can [:read,:update],Pessoa,{:id=>user.pessoa_id}

    end

    if user.coordenador?
      can :manage, :all
      #can [:read,:update],Pessoa,{:id=>user.pessoa_id}
    end

    if user.req_especial?
      can :manage, :all
      #can [:read,:update],Pessoa,{:id=>user.pessoa_id}
    end

    if user.aut_especial?
      can :manage, :all
      #can [:read,:update],Pessoa,{:id=>user.pessoa_id}
    end
   

    

  end
end
