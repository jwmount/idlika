class Gift < ActiveRecord::Base
 
 belongs_to :user
 belongs_to :registry
 has_many   :donors
 has_many   :sources, :dependent => :destroy
  
 serialize :who_can_see

 has_attached_file :photo,
  :styles => {
     :tiny => "50x50#",
     :preview => "175x175>",
     :large => "300x300"
   },
   :default_style => :tiny,
   :default_url => "/images/idlika_logo.png",
   :storage => :s3,
   :s3_credentials => "#{RAILS_ROOT}/config/s3.yml",    # Good, clear msg if not visible
   # visible to client, what she sees
   :url  => ":attachment/:id/:style/:filename",
   # :path is actual file path, also the key, file name is bucket + key, this is the Heroku default
   :path => ":attachment/:id/:style/:filename",
   :bucket => ENV["S3_BUCKET"]
   
 # Paperclip Validations
 validates_associated :user
 validates_attachment_presence :photo
 validates_attachment_size :photo, :less_than => 5.megabytes
 validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/jpg', 'image/png', 'image/gif', 'image/tiff']
 
 
end
