class Ability
  include CanCan::Ability

  def initialize(user)
      user ||= User.new  
      if user.admin?
        can :manage, :all
      else
        can :read, :all
      end

      if user.group?
        can :manage, CategoriesBook
      end

      if user.book?
        can :manage, AuthorsBook
      end
  end
end
