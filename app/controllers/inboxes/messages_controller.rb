class Inboxes::MessagesController < Inboxes::BaseController
  # before_filter :init_discussion
  # load_and_authorize_resource
  load_and_authorize_resource :discussion
  load_resource :message, :through => :discussion, :shallow => true

  def create
    @message.user = current_user
    @message.discussion = @discussion
    @message.save

    respond_to do |format|
      format.html { redirect_to @message.discussion }
      format.js
    end
  end

  # private
  #
  # def init_and_check_permissions
  #   @discussion = Discussion.find(params[:discussion_id])
  #   redirect_to discussions_url, :notice => t("inboxes.discussions.can_not_participate") unless @discussion.can_participate?(current_user)
  # end
end
