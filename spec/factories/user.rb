FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "TEST#{n}" }
      sequence(:email) { |n| "TEST#{n}@example.com" }
      grade { 1 }
      password { "password" }
      password_confirmation { "password" }
  end
end
