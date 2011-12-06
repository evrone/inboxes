require 'spec_helper'

describe Message do
  it "should not be visible to new speaker" do
    discussion = Factory(:discussion)
    old_user = Factory(:user)
    discussion.add_speaker(old_user)
    message = Message.create!(:discussion => discussion, :user => old_user, :body => Factory.next(:string))
    
    sleep 2
    
    new_user = Factory(:user)
    discussion.add_speaker(new_user)
    message.visible_for?(new_user).should be_false
  end
  
  it "should be visible to old speaker" do
    discussion = Factory(:discussion)
    user = Factory(:user)
    discussion.add_speaker(user)
    message = Message.create!(:discussion => discussion, :user => user, :body => Factory.next(:string))
    
    sleep 5
    
    message.visible_for?(user).should be_true
  end
end
