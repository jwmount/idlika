class UserSession < Authlogic::Session::Base
  
attr :current_registry
  
  def setRegistry=(registry)
    current_registry = registry
  end
  
  def currentRegistry
    current_registry
  end
  
end