FactoryBot.define do
  factory :user do
    name {'tester1'}
    email {'tester1@example.com'}
    password {'00000000'}
    password_digest {'00000000'}
    admin {false}
  end

  factory :second_user, class: User do
    name {'tester2'}
    email {'tester2@example.com'}
    password {'00000000'}
    password_digest {'00000000'}
    admin {true}
  end
end
