class Ability
  include CanCan::Ability

  def initialize(user)
    # basic ability definition
		if user.present?
				if user.has_role?(:admin)
					can :manage,:all
				else
		  			can :read, Debt, :debitor_id => user.id, :creditor_id => user.id
					can :create, Debt
					can :update, Debt, :debitor_id => user.id, :creditor_id => user.id
					can :get_file, Debt, :debitor_id => user.id, :creditor_id => user.id
				end
		else
				can :index, Debt
		end
  end
end
