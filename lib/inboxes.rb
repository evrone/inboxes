require "inboxes/version"
require "inboxes/railtie"
require "inboxes/engine"

module Inboxes
  # Your code goes here...
  
  def self.configure(&block)
    yield @config ||= Inboxes::Configuration.new
  end

  # Global settings for Inboxes
  def self.config
    @config
  end

  # need a Class for 3.0
  class Configuration #:nodoc:
    include ActiveSupport::Configurable
    config_accessor :user_name

    def param_name
      config.param_name.respond_to?(:call) ? config.param_name.call() : config.param_name 
    end
  end
  
end
