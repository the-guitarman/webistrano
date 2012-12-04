FactoryGirl.define do
  factory :role do
    sequence(:name) { |n| "Role %04d" % n }
    stage       { |a| a.association(:stage) }
    host        { |a| a.association(:host) }
    primary     0
    no_release  0
    no_symlink  0
  end
end
