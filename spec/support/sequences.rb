Factory.sequence :string do |n|
  "Lorem ipsum #{n}"
end

Factory.sequence :boolean do |n|
  (n % 2 == 0 ? true : false)
end

Factory.sequence :tag_list do |n|
  "Tag_#{n}, Tag2_#{n}, Tag3_#{n}"
end

Factory.sequence :integer do |n|
  n * 20
end

Factory.sequence :email do |n|
  "email#{n}@example.com"
end

Factory.sequence :url do |n|
  "http://example.com/#{n}"
end

Factory.sequence :login do |n|
  "login#{n}"
end

Factory.sequence :password do |n|
  "password#{n}"
end

Factory.sequence :text do |n|
  "#{n}. Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
end