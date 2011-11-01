class Speaker < ActiveRecord::Base
  belongs_to :user
  belongs_to :discussion
  
  validates_uniqueness_of :user_id, :scope => :discussion_id
  validates :user, :discussion, :presence => true
  
  after_destroy :destroy_discussion_view
  after_destroy :destroy_discussion
  
  private
  
  def destroy_discussion_view
    @view = DiscussionView.find_by_user_id_and_discussion_id(self.user_id, self.discussion_id)
    @view.destroy if @view
  end
  
  def destroy_discussion
    self.discussion.destroy unless self.discussion.speakers.any?
  end
  
end
