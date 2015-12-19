class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)

    can :create, :session if user.roles == []

    if user.has_role? :user
      can :destroy, :session # users can sign out
      can :show, User, :id => user.id # users can view their own profile
      can :update, User, :id => user.id # users can update their own profile
      can :read, RequestAttachment
      can :create, RequestAttachment
      can :update, RequestAttachment, :user_id => user.id
      can :destroy, RequestAttachment, :user_id => user.id
      can :read, Template
    end

    can :manage, :all if user.has_role? :admin

    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
