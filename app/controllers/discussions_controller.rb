class DiscussionsController < ApplicationController
  before_filter :authenticate_user!
  # before_filter :check_permissions, :only => :show
  
  before_filter :load_and_check_discussion_recipient, :only => [:create, :new]
  
  def index
    # показываем дискуссии юзера, и те куда его присоеденили
    # так как имеем массив дискуссий, его пагинация будет через хак
    @discussions = current_user.discussions
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @discussions }
    end
  end

  # GET /discussions/1
  # GET /discussions/1.json
  def show
    @discussion = Discussion.includes(:messages, :speakers).find(params[:id])
    redirect_to root_url, :notice => t("views.discussions.can_not_participate") unless @discussion.can_participate?(current_user)
    
    @discussion.mark_as_read_for(current_user) # сделаем прочтенной для пользователя
  end

  # GET /discussions/new
  # GET /discussions/new.json
  def new
    # @discussion = Discussion.new
    @discussion.messages.build
  end
  
  # POST /discussions
  # POST /discussions.json
  def create
    # @discussion = Discussion.new(params[:discussion])
    @discussion.add_recipient_token current_user.id
    
    @discussion.messages.each do |m|
      m.discussion = @discussion
      m.user = current_user
    end
    
    
    if @discussion.save
      redirect_to @discussion, :notice => t("views.discussions.started")
    else
      render :action => "new"
    end
  end
  
  def leave
    @discussion.remove_speaker(current_user)
    redirect_to discussions_url, :notice => t("views.discussions.leaved")
  end
  
  private
  
  def load_and_check_discussion_recipient
    @discussion = Discussion.new((params[:discussion] ? params[:discussion] : {}))
    @discussion.recipient_tokens = params[:recipients] if params[:recipients]
    
    # проверка, существует ли уже дискуссия с этим человеком
    if @discussion.recipient_ids && @discussion.recipient_ids.size == 1
      user = User.find(@discussion.recipient_ids.first)
      discussion = Discussion.find_between_users(current_user, user)
      if discussion
        # дискуссия уже существует, добавим в нее написанное сообщение
        @discussion.messages.each do |m|
          Message.create!(:discussion => discussion, :user => current_user, :body => m.body) if m.body
        end
        # перекидываем на нее
        redirect_to discussion_url(discussion), :notice => t("views.discussions.exists", :user => user[Inboxes::config.user_name])
      end
    end
  end
  
end
