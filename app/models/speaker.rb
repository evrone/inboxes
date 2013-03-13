class Speaker < ActiveRecord::Base

  attr_accessible :discussion, :user, :updated_at

  belongs_to :user
  belongs_to :discussion

  validates_uniqueness_of :user_id, :scope => :discussion_id
  validates :user, :discussion, :presence => true

  after_destroy :destroy_discussion

  private

  def destroy_discussion
    self.discussion.destroy unless self.discussion.speakers.any?
  end

end
