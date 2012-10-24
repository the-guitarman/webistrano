FactoryGirl.define do
  factory :recipe do
    sequence(:name) { |n| "Recipe %04d" % n }
    description "A description for this recipe"
    body        '# a recipe'
  end
end
