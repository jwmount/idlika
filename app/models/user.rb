class User < ActiveRecord::Base
  acts_as_authentic 
  attr_accessible :username, :email, :password, :password_confirmation
  
  has_many :gifts, :dependent => :destroy
  has_many :registries, :dependent => :destroy
#  has_many :roles, :through => :registries, :source => :user

  def role_symbols
    roles.map do |role|
      role.username.underscore.to_sym
    end
  end
  
end
