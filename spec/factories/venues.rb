# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :venue do
    name "Ellui"
    phone "010 -2345 - 2345"
    address "123 Plastic Surgery St, Gangnam, Korea"
    misc "Gangnam's best nightclub"
    facebook "facebook.com/ellui"
    cafe "cafe.naver.com/ellui"
    website "ellui.com"
  end
end