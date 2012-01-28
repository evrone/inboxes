# FactoryGirl.define do
#   
#   factory :user do
#     email {Factory.next(:email)}
#     first_name 'user'
#     last_name 'usered'
#     username {Factory.next(:login)}
#     password "foobar"
#     password_confirmation { |u| u.password }
#     role 2
#   end
# 
#   factory :discussion do
#     recipient_ids {[Factory(:user).id, Factory(:user).id]}
#   end
# 
#   factory :message do
#     association :user
#     association :discussion
#     # user {Factory(:user)}
#     # discussion {Factory(:discussion)}
#   end
# end