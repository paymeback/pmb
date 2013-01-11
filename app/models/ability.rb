class Ability
  include CanCan::Ability

  def initialize(user)
    # basic ability definition
		if user.present?
				if user.has_role?(:admin)
					can :manage,:all
				else
		  		can :read, Debt
					can :create, Debt
					can :update, Debt
				end
		else
				can :read, :all
		end
  end
end
