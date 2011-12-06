require 'spec_helper'

describe Inboxes::SpeakersController do

  context("Authenticated admin") do
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      @user = Factory(:user)
      @user.set_role(:admin)
      sign_in @user
    end

    it "should add speaker to discussion" do
      discussion = Factory(:discussion, :recipient_ids => [@user.id, Factory(:user).id])
      post(:create,
        :discussion_id => discussion,
        :speaker => {
          :user_id => Factory(:user).id
        }
      )
      response.should redirect_to(discussion_url(discussion))
      flash[:notice].should =~ /Собеседник успешно добавлен/i
    end
    
    # it "should not add bad speaker to discussion" do
    #   discussion = Factory(:discussion)
    #   
    #   lambda {
    #     post(:create,
    #       :discussion_id => discussion
    #     )
    #   }.should raise_error(ActiveRecord::RecordNotFound)
    # end
  end
  
  context("User") do
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      @user = Factory(:user)
      @user.set_role(:user)
      sign_in @user
    end
    
    it "should add speaker to discussion if he is participant if this discussion" do
      Speaker.any_instance.stubs(:valid?).returns(true)
      discussion = Factory(:discussion, :recipient_ids => [@user.id, Factory(:user).id])
      # puts discussion.can_participate?(@user)
      # new_user = Factory(:user)
      post(:create,
        :discussion_id => discussion,
        :speaker => {
          :user_id => Factory(:user).id
        }
      )
      response.should redirect_to(discussion_url(discussion))
      # response.should redirect_to(root_url)
      flash[:notice].should =~ /Собеседник успешно добавлен/i
    end
    
    # дописать спек
    it "should not add speaker to discussion if he is not participant if this discussion" do
      discussion = Factory(:discussion)
      post(:create,
        :discussion_id => discussion,
        :speaker => {
          :user_id => Factory(:user).id
        }
      )
      response.should redirect_to(root_url)
    end
  end
end
