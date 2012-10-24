FactoryGirl.define do
  factory :deployment do
    stage { |a| a.association(:stage) }
    user  { |a| a.association(:user)  }
    sequence(:task)     { |n| "task-%04d" % n }
    sequence(:revision) { |n| "rev-%04d" % n }
    status   'running'
    prompt_config({})
    roles([])
    excluded_host_ids([])
    override_locking false
    description "A deployment description"
  end
end
