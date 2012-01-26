require 'spec_helper'

describe Inboxes::DiscussionsController do
  context "Guest" do
    it "should not see discussions list" do
      get :index
      response.should redirect_to(sign_in_url)
    end
    
    it "should not see new action" do
      get :new
      response.should redirect_to(sign_in_url)
    end
    
    it "should not create discussion if model is valid" do
      recipient_ids = [Factory(:user).id, Factory(:user).id]
      post(:create,
        :discussion => {
          :recipient_ids => recipient_ids,
          :messages_attributes => {
            0 => {:body => Factory.next(:string)}
          }
        } 
      )
      
      response.should redirect_to(sign_in_url)
    end

  end
  
  context("Authenticated admin") do
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      @user = Factory(:user)
      @user.set_role(:admin)
      sign_in @user
    end
    
    it "should see discussions list" do
      get :index
      response.should render_template(:index)
    end
    
    it "should see new action" do
      get :new
      response.should render_template(:new)
    end
    
    it "should open discussion" do
      discussion = Factory.build(:discussion)
      discussion.recipient_ids = [@user, Factory(:user)].map { |u| u.id }
      discussion.save.should be true
      
      get(:show, :id => discussion)
      response.status.should be 200
    end
    
    it "should create private discussion if model is valid" do
      recipient_ids = [Factory(:user).id, Factory(:user).id]
      post(:create,
        :discussion => {
          :recipient_ids => recipient_ids,
          :messages_attributes => {
            0 => {:body => Factory.next(:string)}
          }
        } 
      )
      
      response.should redirect_to(discussion_url(assigns[:discussion]))
    end
    
    it "should create group discussion if model is valid" do
      recipient_ids = [Factory(:user).id, Factory(:user).id, Factory(:user).id]
      post(:create,
        :discussion => {
          :recipient_ids => recipient_ids,
          :messages_attributes => {
            0 => {:body => Factory.next(:string)}
          }
        } 
      )
      
      response.should redirect_to(discussion_url(assigns[:discussion]))
    end
    
    it "should not create discussion with empty message" do
      discussion = Discussion.new
      discussion.recipient_ids = [Factory(:user).id, Factory(:user).id, Factory(:user).id]
      post(:create, :discussion => discussion)
      
      response.should render_template(:new)
    end
    
  end

end