FactoryGirl.define do
  factory :host do
    sequence(:name) { |n| "%04d.example.com" % n }
  end
end
