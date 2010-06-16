module GiftsHelper
  
  def community_names
    %w[ 'John' 'Mom']
  end
  
  def friend?
    id == friend_id
  end
  
end
