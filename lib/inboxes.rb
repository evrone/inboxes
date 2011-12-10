require "inboxes/version"
require "inboxes/railtie"
require "inboxes/ability"
require "inboxes/engine"
require "inboxes/active_record_extension"


module Inboxes

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
    config_accessor :faye_host
    config_accessor :faye_port
    config_accessor :faye_enabled

    def param_name
      config.param_name.respond_to?(:call) ? config.param_name.call() : config.param_name
    end
  end

  # adding method inboxes for models
  ActiveRecord::Base.extend(Inboxes::ActiveRecordExtension)

end
