class SpeakersController < ApplicationController
  before_filter :init_and_check_permissions
  
  def create
    # check permissions
    raise ActiveRecord::RecordNotFound unless params[:speaker] && params[:speaker][:user_id]
    @user = User.find(params[:speaker][:user_id])
    
    flash[:notice] = t("views.speakers.added") if @discussion.add_speaker(@user)
    redirect_to @discussion
  end
  
  def destroy
    @speaker = Speaker.find(params[:id])
    @speaker.destroy
    flash[:notice] = t("views.speakers.removed")
    redirect_to @discussion.speakers.any? && @discussion.can_participate?(current_user) ? @discussion : discussions_url
  end
  
  private
  
  def init_and_check_permissions
    @discussion = Discussion.find(params[:discussion_id])
    redirect_to discussions_url, :notice => t("views.discussions.can_not_participate") unless @discussion.can_participate?(current_user)
  end
end
