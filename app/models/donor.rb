class Donor < ActiveRecord::Base

  belongs_to :gift
  belongs_to :user
  
end
