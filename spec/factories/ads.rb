# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :ad do
    link "http://nytimes.com"
    ko_link "http://korea.com"
  end
end
