# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :post do
    title "MyText"
    en_body "MyText"
    ko_body "MyText"
    short_title "MyString"
    published true
    
    factory :unpublished_post do
      title "bla"
      published false
    end
  end
end
