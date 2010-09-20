# Be sure to restart your server when you modify this file
# require "action_mailer"
require 'net/http'
# Specifies gem version of Rails to use when vendor/rails is not present

RAILS_GEM_VERSION = '2.3.8' unless defined? RAILS_GEM_VERSION
ENV['IDLIKA_VERSION'] = '0.1.59'
ENV['DEFAULT_REGISTRY_NAME'] = 'Recent Additions'
ENV['SHOW_LINKS'] = 'yes'

ENV['S3_BUCKET'] = "idlika.com"
ENV['S3_KEY'] = 'AKIAJG2MA6FIXEPKVC6Q'
ENV['S3_SECRET'] = '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'

ENV['IDLIKA_EMAIL_NAME'] = 'info@idlikallc.com'
ENV['IDLIKA_EMAIL_PSWD'] = 'idl1kallc'
ENV['IDLIKA_DOMAIN'] = 'idlika.com'

ENV['SENDGRID_PASSWORD'] = '6c849eca761a22707a'
ENV['SENDGRID_USERNAME'] = 'app156298@heroku.com'

ENV['INVITATION_USERNAME'] = 'guest'
ENV['INVITATION_PASSWORD'] = 'guest'

# Facebook Registration 
# App Name:	idlika
# App URL:	www.idlika.com/home/
# App ID:	143400042352343
# App Secret:	1482ae818ff5f6adae68679612f17a79
ENV['FACEBOOK_APP_ID'] = '143400042352343'

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  # Settings in config/environments/* take precedence over those specified here.
  # Application configuration should go into files in config/initializers
  # -- all .rb files in that directory are automatically loaded.

  # Add additional load paths for your own custom dirs
  # config.load_paths += %W( #{RAILS_ROOT}/extras )

  # Use the database for sessions instead of the file system
  # (create the session table with 'rake db:sessions:create')
  config.action_controller.session_store = :active_record_store
 #  generate the secret string using $ rake secret
  config.action_controller.session = {
    :secret => 'cc335a614b9a48a8e247b13e96eb139caff06fca938edc8548a5ff017f01b0c8ca7de5ae863f43098ba738e6ab72720df4050d744cc55c4eca1ddf7eb1f0ab97'
  }
  config.action_controller.allow_forgery_protection = false
  # Specify gems that this application depends on and have them installed with rake gems:install
  # config.gem "bj"
  # config.gem "hpricot", :version => '0.6', :source => "http://code.whytheluckystiff.net"
  # config.gem "sqlite3-ruby", :lib => "sqlite3"
  # config.gem "aws-s3", :lib => "aws/s3"
  # for HEROKU put both gems in .gems file (>mate .gems to edit),  Case Sensitive!

  config.gem "authlogic"
  config.gem "declarative_authorization", :source => "http://gemcutter.org"
#  config.gem "paperclip"
#  config.gem "rmagick", :lib => "RMagick"
  # http://github.com/scottburton11/paperclip-rightaws-fails/blob/master/config/environment.rb
  config.after_initialize do
    config.gem "right_aws"
  end
  config.gem "sendgrid"

  # Only load the plugins named here, in the order given (default is alphabetical).
  # :all can be used as a placeholder for all plugins not explicitly named
  # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

  # Skip frameworks you're not going to use. To use Rails without a database,
  # you must remove the Active Record framework.
  # config.frameworks -= [ :active_record, :active_resource, :action_mailer ]

  # Activate observers that should always be running
  # config.active_record.observers = :cacher, :garbage_collector, :forum_observer

  # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
  # Run "rake -D time" for a list of tasks for finding time zone names.
  config.time_zone = 'UTC'

  # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
  # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}')]
  # config.i18n.default_locale = :de

  # Show full error reports and disable caching
    config.gem "actionmailer"       # 'actionmailer' is the name of the gem
    config.action_mailer.raise_delivery_errors = true
    config.action_mailer.delivery_method = :smtp
  #    config.action_mailer.default_content_method = :smtp     works on development without this!
  #    MemberMailer::Base.delivery_method = :smtp
  #    MemberMailer::Base.default_content_type = "text/html"
  #    MemberMailer::Base.smtp_settings = {
    config.action_mailer.smtp_settings = {
        :address        => "smtp.sendgrid.net",
        :port           => "25",
        :authentication => :login,
        :user_name      => ENV['SENDGRID_USERNAME'],
        :password       => ENV['SENDGRID_PASSWORD'],
        :domain         => ENV['IDLIKA_DOMAIN']
      }
    config.action_controller.consider_all_requests_local = true
    config.action_view.debug_rjs                         = true
    config.action_controller.perform_caching             = false

end