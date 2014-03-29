# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :slide do
    en_title "wow"
    ko_title "nice article"
    en_description "blablabla"
    ko_description "click here"
    link "http://nytimes.com"
    anchor "Read the news"
    active false
  end
end
