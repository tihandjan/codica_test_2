class User < ActiveRecord::Base
  rolify
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  include DeviseTokenAuth::Concerns::User

  def admin?
    has_role? :admin    
  end

  def group?
    has_role? :group    
  end

  def book?
    has_role? :book    
  end
end
