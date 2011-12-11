require 'rails'
require "inboxes/ability"

module Inboxes
  class Railtie < ::Rails::Railtie
    config.inboxes = ActiveSupport::OrderedOptions.new

    initializer "inboxes.configure" do |app|
      Inboxes.configure do |config|
        config.user_name = app.config.inboxes[:user_name] || "email"
        config.faye_enabled = app.config.inboxes[:faye_enabled] || false
        config.faye_host = app.config.inboxes[:faye_host] || "localhost"
        config.faye_port = app.config.inboxes[:faye_port] || "9292"
      end

      # app.config.middleware.insert_before "::Rails::Rack::Logger", "Inboxes::Middleware"
    end

    # def self.activate
    #   Ability.register_ability(InboxesAbility)
    # end
  end
end