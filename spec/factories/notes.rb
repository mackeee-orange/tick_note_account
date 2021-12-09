FactoryBot.define do
  factory :note do
    association :author, factory: :account

    sequence(:title) { |n| "title#{n}" }
    content { 'hoge' }
    expired_at { Time.current + 1.week }
    is_public { true }
  end
end
