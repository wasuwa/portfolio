FactoryBot.define do
  factory :article do
    content { "これはテストです" }
    created_at { 10.minutes.ago }
    title { "これはテストです" }
    association :user
    
    trait :day_before_yesterday do
      content { "2日前に投稿されたものです" }
      created_at { 2.days.ago }
      title { "2日前に投稿されたものです" }
    end

    trait :yesterday do
      content { "1日前に投稿されたものです" }
      created_at { 1.day.ago }
      title { "1日前に投稿されたものです" }
    end

    trait :now do
      content { "今投稿されたものです" }
      created_at { Time.zone.now }
      title { "今投稿されたものです" }
    end
  end
end