class Registry < ActiveRecord::Base

  belongs_to :user
  has_many :gifts, :dependent => :destroy
  
  
end
