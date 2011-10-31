class Message < ActiveRecord::Base

  default_scope order(:created_at)
  
  belongs_to :discussion, :counter_cache => true
  belongs_to :user
  
  validates :user, :discussion, :body, :presence => true
  
  after_save :touch_discussion_and_mark_as_read
  
  def visible_for? user
    self.created_at.to_i >= self.discussion.user_invited_at(user).to_i
  end
  
  private
  
  def touch_discussion_and_mark_as_read
    self.discussion.touch
    self.discussion.mark_as_read_for(self.user)
  end
end
