FactoryBot.define do
  factory :comment do
    association :user
    association :article
    content { "コメントです" }
  end
end
