# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :band_manager do
    user nil
    band nil
    approved false
  end
end
