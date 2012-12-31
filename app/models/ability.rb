class Ability
  include CanCan::Ability

  def initialize(user)
    # basic ability definition
    	can :read, :all
	can :create, Debt
	can :update, Debt
	cannot :destroy, Debt
  end
end
