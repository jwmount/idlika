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
  
  def Xdefault_registry
    gifts = user.gifts.find( :all, :order_by => :created_at, :limit => 10 )
    @registry = registry if registry.created_at
  end
    
  validates_presence_of :username
  validates_presence_of :email
  validates_length_of :password, :minimum => 4
  validates_length_of :password_confirmation, :minimum => 4
  
end

