# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :event do
    name "Big party"
    contact "010 -2345 - 2345"
    price "$1000"
    info "it's a massive party"
    date Date.tomorrow
    approved true
    user nil

    factory :unapproved_event do
    	name "evan's birthday"
    	approved false
    end
  end
end