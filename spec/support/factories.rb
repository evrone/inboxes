Factory.sequence :email do |n|
  "email#{n}@example.com"
end

Factory.sequence :string do |n|
  "Lorem ipsum #{n}"
end

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
