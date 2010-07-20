# Be sure to restart your server when you modify this file

# MUST be on for dev, MUST remove this for staging and production
 require 'ActionMailer'

# Specifies gem version of Rails to use when vendor/rails is not present
# RAILS_GEM_VERSION = '2.3.3' unless defined? RAILS_GEM_VERSION
ENV['IDLIKA_VERSION'] = '0.1.036'

ENV['S3_BUCKET'] = "idlika.com"
ENV['S3_KEY'] = 'AKIAJG2MA6FIXEPKVC6Q'
ENV['S3_SECRET'] = '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'

ENV['IDLIKA_EMAIL_NAME'] = 'info@idlikallc.com'
ENV['IDLIKA_EMAIL_PSWD'] = 'idl1kallc'
ENV['IDLIKA_DOMAIN'] = 'idlika.com'

ENV['SENDGRID_PASSWORD'] = '6c849eca761a22707a'
ENV['SENDGRID_USERNAME'] = 'app156298@heroku.com'


# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  # Settings in config/environments/* take precedence over those specified here.
  # Application configuration should go into files in config/initializers
  # -- all .rb files in that directory are automatically loaded.

  # Add additional load paths for your own custom dirs
  # config.load_paths += %W( #{RAILS_ROOT}/extras )

  # Specify gems that this application depends on and have them installed with rake gems:install
  # config.gem "bj"
  # config.gem "hpricot", :version => '0.6', :source => "http://code.whytheluckystiff.net"
  # config.gem "sqlite3-ruby", :lib => "sqlite3"
  # config.gem "aws-s3", :lib => "aws/s3"
  # for HEROKU put both gems in .gems file (>mate .gems to edit),  Case Sensitive!
  
  config.gem "action_mailer"   appears to be necessary to remove this for deployment; also from .gems
  config.gem "authlogic"
  config.gem "declarative_authorization", :source => "http://gemcutter.org"
  config.gem "paperclip"
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
  
  config.action_mailer.raise_delivery_errors = true
  ActionMailer::Base.delivery_method = :smtp
  ActionMailer::Base.default_content_type = "text/html"
  ActionMailer::Base.smtp_settings = {
    :address        => "smtp.sendgrid.net",
    :port           => "25",
    :authentication => :login,
#    :user_name      => ENV['IDLIKA_EMAIL_NAME'],
    :user_name      => ENV['SENDGRID_USERNAME'],
#    :password       => ENV['IDLIKA_EMAIL_PASSWORD'],
    :password       => ENV['SENDGRID_PASSWORD'],
    :domain         => ENV['IDLIKA_DOMAIN'],
  }
end