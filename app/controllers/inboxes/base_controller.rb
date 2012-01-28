class Inboxes::BaseController < ApplicationController
  private

  def init_discussion
    @discussion = Discussion.find(params[:discussion_id])
  end
end