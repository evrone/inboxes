class Inboxes::SpeakersController < Inboxes::BaseController
  # before_filter :init_discussion
  load_and_authorize_resource :discussion
  load_resource :speaker, :through => :discussion, :shallow => true
  # load_and_authorize_resource

  def create
    raise ActiveRecord::RecordNotFound unless params[:speaker] && params[:speaker][:user_id]
    @user = User.find(params[:speaker][:user_id])
    flash[:notice] = t("inboxes.speakers.added") if @discussion.add_speaker(@user)
    redirect_to @discussion
  end

  def destroy
    @speaker = Speaker.find(params[:id])
    @speaker.destroy
    flash[:notice] = @speaker.user == current_user ? t("inboxes.discussions.leaved") : t("inboxes.speakers.removed")
    redirect_to @discussion.speakers.any? && @discussion.can_participate?(current_user) ? @discussion : discussions_url
  end
end
