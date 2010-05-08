class Gift < ActiveRecord::Base
 
 belongs_to :user
 belongs_to :registry
 has_many :descriptors

 has_attached_file :photo,
   :styles => {
     :tiny => "35x35>",
     :preview => "175x175>",
     :large => "300x300"
   },
   :storage => :s3
   :s3_credentials => "#{RAILS_ROOT}/config/s3.yml",
   :path => "attachment/:id/:style/.extension"
   :bucket => idlika.com
   
 end
