class User < ActiveRecord::Base
  acts_as_authentic 
  attr_accessible :username, :email, :password, :password_confirmation
  
  has_many :gifts, :dependent => :destroy
  has_many :registries, :dependent => :destroy
  has_many :roles, :through => :registries, :source => :user

  def role_symbols
    roles.map do |role|
      role.username.underscore.to_sym
    end
  end
  
  def default_registry
    gifts = user.gifts.find( :all, :order_by => :created_at, :limit => 10 )
    @registry = registry if registry.created_at
  end
    
end
