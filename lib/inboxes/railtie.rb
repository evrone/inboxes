require 'rails'

module Inboxes
  class Railtie < ::Rails::Railtie #:nodoc:
    config.inboxes = ActiveSupport::OrderedOptions.new
    
    initializer "inboxes.configure" do |app|
      Inboxes.configure do |config|
        config.user_name = app.config.inboxes[:user_name] || "email"
      end

      # app.config.middleware.insert_before "::Rails::Rack::Logger", "Inboxes::Middleware"
    end
    
    # initializer 'inboxes' do |app|
    #   ActiveSupport.on_load(:active_record) do
    #     # require 'kaminari/models/active_record_extension'
    #     # ::ActiveRecord::Base.send :include, Kaminari::ActiveRecordExtension
    #   end
    # 
    #   ActiveSupport.on_load(:action_view) do
    #     # ::ActionView::Base.send :include, Kaminari::ActionViewExtension
    #   end
    # end
  end
end