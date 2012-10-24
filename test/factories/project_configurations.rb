FactoryGirl.define do
  factory :project_configuration do
    project { |a| a.association(:project) }
    sequence(:name)    { |n| "Project Configuration %04d" % n }
    sequence(:value)   { |n| "Value %04d" % n }
    prompt_on_deploy 0
  end
end
