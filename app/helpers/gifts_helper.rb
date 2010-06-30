module GiftsHelper
  
  # determine if 'name' has viewing rights
  def allowed_to_view? name
    return true if name == current_user[:username]
    @user_allowed = User.find_by_username name, :select => :id
    @allow = Donor.find_by_gift_id( @user_allowed.id, :conditions => ["allow_id = ?", @gift.id ] )            # "NEED CONDITIONS ON HERE"
    # Donor can see if exists FOR THIS gift
    return false if @allow.nil?
    true
  end
  
  
  
  def XXfriend?
    id == friend_id
  end
  
end
