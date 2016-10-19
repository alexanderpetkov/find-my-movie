FactoryGirl.define do
  factory :movie do
    sequence :title do |n|
      "The Endless Movie Part #{n}"
    end
  end
end
