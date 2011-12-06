require 'spec_helper'

describe Discussion do

  it "should create valid group discussion" do
    discussion = Discussion.new
    discussion.recipient_ids = [Factory(:user), Factory(:user), Factory(:user)].map { |u| u.id }
    discussion.save.should be true
    
    discussion.users.count.should be == 3
    # discussion.private?.should be false
  end
  
  it "should create valid private discussion" do
    discussion = Discussion.new
    discussion.recipient_ids = [Factory(:user).id, Factory(:user).id]
    discussion.save.should be true
    discussion.private?.should be true
  end
  
  it "should add messages to valid discussion" do
    discussion = Discussion.new
    discussion.recipient_ids = [Factory(:user), Factory(:user)].map { |u| u.id }
    discussion.save.should be true
    
    message = Message.new(:user => Factory(:user), :body => Factory.next(:string), :discussion => discussion)
    message.save.should be true
  end
  
  it "should not create discussion without repicients" do
    discussion = Discussion.new
    discussion.save.should be false
  end
  
  it "should not add speakers if discussion is not saved" do
    discussion = Discussion.new
    lambda { discussion.add_speaker(Factory(:user)) }.should raise_error(ArgumentError)
  end
  
  it "should add speakers to discussion" do
    discussion = Factory(:discussion)
    user = Factory(:user)
    discussion.add_speaker(user)
    discussion.users.should include user
  end
  
  it "should remove speaker from discussion" do
    discussion = Factory(:discussion)
    user = Factory(:user)
    discussion.add_speaker(user)
    discussion.remove_speaker(user)
    
    discussion.users.should_not include user
  end
  
  it "should assign discussion as viewed for user" do
    user = Factory(:user)
    discussion = Factory(:discussion)
    discussion.mark_as_read_for(user)
    discussion.unread_for?(user).should be false
  end
  
  it "model with new message should be unread for user" do
    discussion = Factory(:discussion)
    message = Message.create!(:user => Factory(:user), :body => Factory.next(:string), :discussion => discussion)
    discussion.unread_for?(Factory(:user)).should be true
  end
  
  it "attribute user_invited_at should be right" do
    discussion = Factory(:discussion)
    user = Factory(:user)
    speaker = discussion.add_speaker(user)
    speaker.created_at.to_i.should be == discussion.user_invited_at(user).to_i
  end
  
  it "method exists_between_users? should be right" do
    user = Factory(:user)
    user2 = Factory(:user)
    discussion = Discussion.create!(:recipient_ids => [user.id, user2.id])
    
    Discussion.find_between_users(user, user2).should be == discussion
    Discussion.find_between_users(user2, user).should be == discussion
  end
  
  it "method exists_between_users? should be right if there is no discussion" do
    user = Factory(:user)
    user2 = Factory(:user)
    
    Discussion.find_between_users(user, user2).should be_nil
    Discussion.find_between_users(user2, user).should be_nil
  end
  
  it "method exists_between_users? should be right if 2 users are in group discussion" do
    user = Factory(:user)
    user2 = Factory(:user)
    user3 = Factory(:user)
    discussion = Discussion.create!(:recipient_ids => [user.id, user2.id, user3.id])
    
    Discussion.find_between_users(user, user2).should be_nil
    Discussion.find_between_users(user2, user).should be_nil
    Discussion.find_between_users(user2, user3).should be_nil
  end
  
end
