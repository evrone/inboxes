# Implementation class for Cancan gem.  Instead of overriding this class, consider adding new permissions
# using the special +register_ability+ method which allows extensions to add their own abilities.
#
# See http://github.com/ryanb/cancan for more details on cancan.
module Inboxes
  class Ability
    include CanCan::Ability

    class_attribute :abilities
    self.abilities = Set.new

    # Allows us to go beyond the standard cancan initialize method which makes it difficult for engines to
    # modify the default +Ability+ of an application.  The +ability+ argument must be a class that includes
    # the +CanCan::Ability+ module.  The registered ability should behave properly as a stand-alone class
    # and therefore should be easy to test in isolation.
    def self.register_ability(ability)
      self.abilities.add(ability)

    end

    def initialize(user)
      # raise "Initializing 3rd patry"
      # self.clear_aliased_actions

      # can [:index, :create], Discussion
      # can :read, Discussion do |discussion|
      #   discussion.can_participate?(user)
      # end

      #include any abilities registered by extensions, etc.

      Ability.abilities.each do |clazz|
        ability = clazz.send(:new, user)
        @rules = rules + ability.send(:rules)
      end
    end
  end
end
