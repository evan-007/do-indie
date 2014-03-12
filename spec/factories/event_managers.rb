# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :event_manager do
    user nil
    event nil
    approved false
  end
end
