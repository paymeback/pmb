class Ability
  include CanCan::Ability

  def initialize(user)
    # basic ability definition
		if user.present?
				if user.has_role?(:admin)
					can :manage,:all			
				else
		  			can :read, Debt, :debitor_id => user.id
					can :read, Debt, :creditor_id => user.id
					can :create, Debt
					can :update, Debt, :debitor_id => user.id
					can :update, Debt, :creditor_id => user.id
					can :destroy, Debt, :creditor_id => user.id,:cleared => true
				end
		else
				can :index, Debt
		end
  end
end
