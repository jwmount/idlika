module GiftsHelper
  
  # determine if 'name' has viewing rights
  def allowed_to_view? name
    
    return true if is_current_user? name
  
    #Get this user, return FALSE if this user doesn't exist (list comes from .friends, not by row of User table!)
    @user_allowed = User.find_by_username name, :select => :id
    return false if @user_allowed.nil?
    
    @allow = Donor.find_by_gift_id( @user_allowed.id, :conditions => ["allow_id = ?", @gift.id ] )            # "NEED CONDITIONS ON HERE"
  
    # Donor can see if exists FOR THIS gift
    return false if @allow.nil?
    true
  end
  
  def is_current_user? name
    @current_user = current_user
    name == @current_user.username
  end

  def gift_is_in? rid
    return 'unassigned' if rid.nil?
    return (Registry.find rid, :select => :name).name
  end
  
end
