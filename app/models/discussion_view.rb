class DiscussionView < ActiveRecord::Base
  belongs_to :user
  belongs_to :discussion
  
  validates :user, :discussion, :presence => true
  validates_uniqueness_of :user_id, :scope => :discussion_id
end
