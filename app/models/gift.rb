class Gift < ActiveRecord::Base
 
 belongs_to :user
 belongs_to :registry
 has_many :descriptors

 
 end
