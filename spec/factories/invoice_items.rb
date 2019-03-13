FactoryBot.define do
  factory :invoice_item do
    item_id { nil }
    invoice_id { nil }
    quantity { 1 }
    sequence(:unit_price) { |n| n + 1 }
  end
end
