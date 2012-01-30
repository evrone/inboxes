FactoryGirl.define do
  
  factory :user do
    email { Factory.next(:email) }
    name 'user'
    password "foobar"
    password_confirmation { |u| u.password }
  end

  factory :discussion do
    recipient_ids {[Factory(:user).id, Factory(:user).id]}
  end

  factory :message do
    association :user
    association :discussion
  end
end