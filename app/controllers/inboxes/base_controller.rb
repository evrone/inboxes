class Inboxes::BaseController < ApplicationController
  private

  def init_discussion
    @discussion = Discussion.find(params[:discussion_id])
  end

  def current_ability
    @current_ability ||= Inboxes::Ability.new(current_user)
  end
end