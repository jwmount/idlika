module UsersHelper
  
  # [[username, id]]
  def friends
    everyone = User.all.collect { |f| [f.username, f.id] }
    friends = everyone.delete_if {|e| e[0] == current_user.username }
  end
  
end

