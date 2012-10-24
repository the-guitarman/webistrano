FactoryGirl.define do
  factory :user do
    sequence(:login) { |n| "user_%04d" % n }
    sequence(:email) { |n| "user_%04d@example.com" % n }
    admin       false
    password    'hello!'
    password_confirmation { |a| a.password }
  end
end
