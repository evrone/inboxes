# require 'spec_helper'
# 
# describe Inboxes::MessagesController do
# 
#   render_views
#   
#   context "Guest" do
#     it "should redirect guest if he wants to create message" do
#       discussion = Factory(:discussion)
#       # puts discussion.id
#       post :create, :discussion_id => discussion.id
#       response.should redirect_to(sign_in_url)
#     end
#   end
#   
#   context "Authenticated admin" do
#     before(:each) do
#       @request.env["devise.mapping"] = Devise.mappings[:user]
#       @admin = Factory(:admin)
#       @admin.set_role(:admin)
#       sign_in @admin
#     end
# 
#     it "create action should redirect to discussion when model is valid" do
#       Message.any_instance.stubs(:valid?).returns(true)
#       message = Factory(:message)
#       user = Factory(:user)
#       discussion = Factory(:discussion, :recipient_ids => [@admin.id, user.id])
#       post(:create, :discussion_id => discussion.id)
#       response.should redirect_to(discussion_url(discussion))
#     end
# 
#     # it "create action should assign flash with error message" do
#     #   Comment.any_instance.stubs(:valid?).returns(false)
#     #   first_post = Factory(:post)
#     #   post :create, :post_id => first_post
#     # 
#     #   flash[:notice].should =~ /Введите текст комментария!/i
#     # end
#   end
#   
# end
