authorization do

  role :admin do
    has_permission_on [:gifts, :registries], :to => [:index, :show, :new, :create, :edit, :update, :destroy]
  end
  
  role :guest do
    has_permission_on :gifts, :to => :read
    has_permission_on :registries, :to => :read
  end  

  role :member do
    has_permission_on [:gifts, :registries], :to => [:index, :show, :new, :create, :edit, :update, :destroy]
  end
  
end

privileges do
  
  privilege :manage, :includes => [:create, :read, :update, :delete]
  privilege :read, :includes =>   [:index, :show]
  privilege :create, :includes => [:new]
  privilege :update, :includes => [:edit]
  privilege :delete, :includes => [:destroy]
  
end
  