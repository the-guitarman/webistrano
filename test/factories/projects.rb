FactoryGirl.define do
  factory :project do
    sequence(:name) { |n| "Project %04d" % n }
    description "A description for this project"
    template    'rails'
  end
end
