FactoryBot.define do
  factory :item do
    name { "" }
    description { "MyText" }
    unit_price { 1 }
    merchant_id { nil }
  end
end
