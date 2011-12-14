class Inboxes::BaseController < ApplicationController
  private

  def init_discussion
    @discussion = Discussion.find(params[:discussion_id])
  end

  # Needs to be overriden so that we use Spree's Ability rather than anyone else's.
  def current_ability
    # raise "Loading Ability"
    @current_ability ||= Inboxes::Ability.new(current_user)
  end
end