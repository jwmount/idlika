class Registry < ActiveRecord::Base

  belongs_to :user
  has_many :gifts, :dependent => :destroy
  
  validates_associated :user
  
  def null_gates
    self.name = self.name ||= ""
    self.description = self.description ||= ""
  end
  
  def null_gates
    self.name = self.name ||= ""
    self.description = self.description ||= ""
  end
  
end
