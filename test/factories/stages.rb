FactoryGirl.define do
  factory :stage do
    sequence(:name) { |n| "Stage %04d" % n }
    project { |a| a.association(:project) }
  end
end
