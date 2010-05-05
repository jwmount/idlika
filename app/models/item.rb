class Item < ActiveRecord::Base
  
  belongs_to :registry
  belongs_to :gift
  
end
