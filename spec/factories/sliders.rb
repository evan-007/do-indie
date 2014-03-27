# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :slider do
    en_title "New Post"
    ko_title "가나다"
    en_description "This is the best post ever"
    ko_description "가나다"
  end
end
