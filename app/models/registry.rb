class Registry < ActiveRecord::Base

  belongs_to :user
  has_many :gifts, :dependent => :destroy
  
  validates_associated :user
#  validates_exclusion_of :name, :in => %w( ENV['DEFAULT_REGISTRY_NAME'] ), :message => "'Recently Added' is reserved. Please choose another name."
    
  def null_gates
    debugger
    self.name = self.name ||= ""
    self.description = self.description ||= ""
  end
  
end
