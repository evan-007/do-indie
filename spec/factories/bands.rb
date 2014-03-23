# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :band do
    name "Psy"
    contact "010 -2345 - 2345"
    facebook "facebook.com/psy"
    twitter "twitter.com/psy"
    site "doindie.com"
    slug ""
    approved true
    soundcloud "https://soundcloud.com/lukefair"
    user nil

    factory :unapproved_band do
    	approved false
    	name "evan"
    end
  end
end