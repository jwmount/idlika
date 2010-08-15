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
  
  # Possibly none, some, or all of @gifts may visible.
  # @user is may be current_user or the person being visited.
  # so what gifts is current_user allowed to see?  Answer is in Donor.  Result may be nil.
  def can_see?
    return gifts unless session[:friend].defined?
    # Return list of gifts current_user is allowed to see
#friend    donors = Donor.find( :all, :conditions => [ "allow_id = ?", friend_id ] )
    donors = Donor.find( :all, :conditions => [ "allow_id = ?", session[:friend] ] )
    gifts_allowed = donors.collect {|x| x.gift_id } 
    gifts.find( gifts_allowed, :order => "created_at DESC" )
  end

  def friend?
    session[:friend]
  end
  
  def friend name
    begin
      friend = User.find_by_username name
      session[:friend] = friend.id
    rescue
      session[:friend] = nil
    end
  end


  def role_symbols
    roles.map do |role|
      role.username.underscore.to_sym
    end
  end
      
  
end

