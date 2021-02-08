FactoryBot.define do
  factory :comment do
    content { "コメントです" }
    created_at { 10.minutes.ago }
    association :user
    association :article

    trait :day_before_yesterday do
      content { "2日前に投稿されたものです" }
      created_at { 2.days.ago }
    end

    trait :yesterday do
      content { "1日前に投稿されたものです" }
      created_at { 1.day.ago }
    end

    trait :now do
      content { "今投稿されたものです" }
      created_at { Time.zone.now }
    end
  end
end
