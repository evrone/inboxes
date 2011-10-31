require 'rails'

module Inboxes
  class Railtie < ::Rails::Railtie #:nodoc:
    initializer 'inboxes' do |app|
      ActiveSupport.on_load(:active_record) do
        # require 'kaminari/models/active_record_extension'
        # ::ActiveRecord::Base.send :include, Kaminari::ActiveRecordExtension
      end

      ActiveSupport.on_load(:action_view) do
        # ::ActionView::Base.send :include, Kaminari::ActionViewExtension
      end
    end
  end
end