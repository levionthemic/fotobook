class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user

    if user.admin?
      can :manage, :all
      cannot [:show, :edit], User
      cannot :show, Photo
      cannot :show, Album
    else
      can :read, :all
      can :create, User
      can :edit, User
      can :destroy, Photo, user_id: user.id
      can :destroy, Album, user_id: user.id
      can :manage, Like, user_id: user.id
      can :manage, Follow, follower_id: user.id.to_i
    end
  end
end
