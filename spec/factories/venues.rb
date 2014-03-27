# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :venue do
    name "Ellui"
    phone "010 -2345 - 2345"
    address "Gangnam, Korea"
    en_bio "Gangnam's best nightclub"
    facebook "facebook.com/ellui"
    cafe "cafe.naver.com/ellui"
    website "ellui.com"
    approved true
    user nil

    factory :unapproved_venue do
    	name "evan's club"
    	approved false
    end
  end
end