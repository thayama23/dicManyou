FactoryBot.define do
  factory :user do
    name {'tester1'}
    email{'tester1@example.com'}
    password {'tester1@example.com'}
    password_digest {'tester1@example.com'}
    admin {false}
  end


  factory :second_user, class: User do
    name {'tester2'}
    email{'tester2@example.com'}
    password {'tester2@example.com'}
    password_digest {'tester2@example.com'}
    admin {true}
  end
end
