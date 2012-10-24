FactoryGirl.define do
  factory :stage_configuration do
    stage { |a| a.association(:stage) }
    sequence(:name)  { |n| "Stage Configuration %04d" % n }
    sequence(:value) { |n| "Value %04d" % n }
    prompt_on_deploy 0
  end
end
