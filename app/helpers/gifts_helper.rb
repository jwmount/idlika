module GiftsHelper
  
  # determine if 'name' has viewing rights
  def allowed_to_view? name
    return true if name == current_user[:username]
    @user_allowed = User.find_by_username name, :select => :id
    @allow = Donor.find_by_user_id @user_allowed.id
    return false if @allow.nil?
    true
  end
  
  def XXXcommunity_names
    %w[ 'John' 'Mom']
  end
  
  def friend?
    id == friend_id
  end
  
end
