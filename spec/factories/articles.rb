FactoryBot.define do
  factory :article do
    title { "これはテストです" }
    content { "これはテストです" }
    created_at { 10.minutes.ago }
    association :user

    trait :day_before_yesterday do
      title { "2日前に投稿されたものです" }
      content { "2日前に投稿されたものです" }
      created_at { 2.days.ago }
    end

    trait :yesterday do
      title { "1日前に投稿されたものです" }
      content { "1日前に投稿されたものです" }
      created_at { 1.day.ago }
    end

    trait :now do
      title { "今投稿されたものです" }
      content { "今投稿されたものです" }
      created_at { Time.zone.now }
    end
  end
end
