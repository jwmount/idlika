class User < ActiveRecord::Base
  acts_as_authentic 
  attr_accessible :username, :email, :password, :password_confirmation, :terms_accepted_cb
  
  has_many :donors 
  has_many :gifts,      :dependent => :destroy
  has_many :registries, :dependent => :destroy
  has_many :roles,      :through => :registries, :source => :user
  has_many :sources,    :dependent => :destroy
  
  serialize :friends
  
  validates_presence_of :username
  validates_presence_of :email
#  validates_acceptance_of :terms_accepted_cb

  
  def role_symbols
    roles.map do |role|
      role.username.underscore.to_sym
    end
  end
  
  #becomes a filter at some point
  def null_gates
    self.friends = self.friends ||= {}
    self.username = self.username ||= ""
    self.email = self.email ||= ""
  end

end

