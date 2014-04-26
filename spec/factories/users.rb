# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    username "justatest"
    email "dd@example.com"
    password "duckling"
    password_confirmation "duckling"
    

    factory :admin_user do
      admin true
      username "something"
      email "alt@alt.com"
      get_email false
    end
    
    factory :blogger do
      blogger true
      username "asdfasdf"
      email "not@thesame.com"
    end
  end
end