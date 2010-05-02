authorization do
  
  role :guest do
    has_permission_on :gifts, :to => [:index, :show]
    has_permission_on :groups, :to => [:index]
    has_permission_on :givers, :to => [:new, :create] do
      if_attribute :user => is { user }
    end
  end
  
end
