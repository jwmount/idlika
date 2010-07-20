class User < ActiveRecord::Base
  acts_as_authentic 
  attr_accessible :username, :email, :password, :password_confirmation
  
  has_many :donors
  has_many :gifts, :dependent => :destroy
  has_many :registries, :dependent => :destroy
  has_many :roles, :through => :registries, :source => :user
  has_many :sources, :dependent => :destroy
  
  serialize :friends
  
  validates_presence_of :username
  validates_presence_of :email
  
  # Possibly none, some, or all of @gifts may visible to current_user
  # watch your personna here!  @user is the Givee, person who we're visiting to she what she wants...
  # so what gifts is current_user allowed to see?  Answer is in Donor.  Result may be nil.
  def can_see? current_user
    # list of gifts current_user is allowed to see
    @donors = Donor.find( :all, :conditions => [ "allow_id = ?", current_user[:id]] )
    debugger
    @gifts_allowed = @donors.collect {|x| x.gift_id } 
    @gifts = gifts.find( @gifts_allowed, :order => "created_at DESC" )
  end

  def role_symbols
    roles.map do |role|
      role.username.underscore.to_sym
    end
  end
      
  
end

