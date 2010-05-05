class Gift < ActiveRecord::Base
 
 belongs_to :user
 has_one :descriptor
 has_many :items            # an item is a gift in a registry
  
 end
