# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :event do
    name "Big party"
    contact "010 -2345 - 2345"
    price "$1000"
    info "it's a massive party"
    date Date.tomorrow
  end
end