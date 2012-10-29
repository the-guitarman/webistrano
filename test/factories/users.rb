FactoryGirl.define do
  factory :user do
    sequence(:login) { |n| "user_%04d" % n }
    sequence(:email) { |n| "user_%04d@example.com" % n }
    admin       false
    password    '123456'
    password_confirmation { |a| a.password }
  end

  factory :admin, parent: :user do
    sequence(:login) { |n| "admin_%04d" % n }
    sequence(:email) { |n| "admin_%04d@example.com" % n }
    admin       true
  end

end
