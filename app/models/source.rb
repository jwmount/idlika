class Source < ActiveRecord::Base

  belongs_to :gift
  belongs_to :user
  
  validates_associated :gift
  validates_associated :user

end
