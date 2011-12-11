require "inboxes/ability"

module Inboxes
  class Engine < ::Rails::Engine
    def self.activate
      Ability.register_ability(InboxesAbility)
    end

    config.to_prepare &method(:activate).to_proc
  end
end