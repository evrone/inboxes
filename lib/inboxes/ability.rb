require "cancan"

module Inboxes
  class InboxesAbility
    include ::CanCan::Ability

    def initialize(user)
      # Discussion
      # raise "Registered!"
      if user
        can [:index, :create], Discussion
        can :read, Discussion do |discussion|
          discussion.can_participate?(user)
        end
      end

      # Message
      # can :create, Message do |message|
      #   message.discussion.can_participate?(user)
      # end
      #
      # # Speaker
      # can [:create, :destroy], Speaker do |speaker|
      #   speaker.discussion.can_participate?(user)
      # end
    end
  end

end