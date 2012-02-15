class Inboxes::DiscussionsController < Inboxes::BaseController
  load_and_authorize_resource
  before_filter :load_and_check_discussion_recipient, :only => [:create, :new]

  def index
    @discussions = current_user.discussions
  end
  
  def show
    @discussion.mark_as_read_for(current_user)
  end
  
  def new
    @discussion.messages.build
  end
  
  def destroy
    @discussion.destroy
    
    flash[:notice] = t("inboxes.discussions.removed")
    begin
      redirect_to :back
    rescue ActionController::RedirectBackError
      redirect_to discussions_url
    end
  end

  def create
    @discussion.add_recipient_token current_user.id

    @discussion.messages.each do |m|
      m.discussion = @discussion
      m.user = current_user
    end

    if @discussion.save
      redirect_to @discussion, :notice => t("inboxes.discussions.started")
    else
      render :action => "new"
    end
  end

  private
  
  def load_and_check_discussion_recipient
    # initializing model for new and create actions
    @discussion = Discussion.new(params[:discussion].presence || {})

    # checking if discussion with this user already exists
    if @discussion.recipient_ids && @discussion.recipient_ids.size == 1
      user = User.find(@discussion.recipient_ids.first)
      discussion = Discussion.find_between_users(current_user, user)
      if discussion
        # it exists, let's add message and redirect current user
        @discussion.messages.each do |message|
          Message.create(:discussion => discussion, :user => current_user, :body => message.body) if message.body
        end
        # redirecting to that existing object
        redirect_to discussion_url(discussion), :notice => t("inboxes.discussions.already_exists", :user => user[Inboxes::config.user_name])
      end
    end
  end
end