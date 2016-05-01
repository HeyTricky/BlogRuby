class Ability
  include CanCan::Ability

  def initialize(user)
    user ||=User.new
    

    if user.has_role? :admin
        can :read, :all
        can :create, :all
        can :update, [Post,Comment]
        can :update, User do |u|
            u.id != user.id
        end
        can :destroy, :all
    else
        if user.has_role? :moderator
            can :read, :all
            can :create, Post
            can :create, Comment
            can :update, Post
            can :update, Comment
            can :destroy, Post
            can :destroy, Comment
        else
            if user.has_role? :user
                can :read, :all
                can :create, [Post,Comment]
                can :update, Post, :user_id => user.id
                can :update, Comment, :user_id => user.id
                can :destroy, Post, :user_id => user.id
                can :destroy, Comment, :user_id => user.id
            else
                can :read, :all
            end
        end
    end

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
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities
end
end
