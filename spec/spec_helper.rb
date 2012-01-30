$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'rails'
require 'active_record'
require 'inboxes'
require 'factory_girl'

# require 'database_cleaner'
# Ensure we use 'syck' instead of 'psych' in 1.9.2
# RubyGems >= 1.5.0 uses 'psych' on 1.9.2, but
# Psych does not yet support YAML 1.1 merge keys.
# Merge keys is often used in mongoid.yml
# See: http://redmine.ruby-lang.org/issues/show/4300
if RUBY_VERSION >= '1.9.2'
  YAML::ENGINE.yamler = 'syck'
end
# require 'fake_gem'
require 'fake_app'

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

RSpec.configure do |config|
  config.include Devise::TestHelpers, :type => :controller
  config.color_enabled = true
end