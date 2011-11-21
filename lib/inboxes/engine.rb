require "inboxes/ability"

module Inboxes
  class Engine < ::Rails::Engine
    # raise "Engine Activated"
    def self.activate
      Ability.register_ability(InboxesAbility)
      # raise "Activated"
    end
    
    def load_tasks
    end
    
    config.to_prepare &method(:activate).to_proc
  end
end