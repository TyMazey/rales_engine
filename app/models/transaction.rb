class Transaction < ApplicationRecord
  belongs_to :invoice

  enum result: ["failed", "success"]

  def self.revenue_for_date(date)
    select("transactions.created_at, sum(invoice_items.unit_price * invoice_items.quantity) AS total_revenue")
    .joins(invoice: :invoice_items)
    .where(result: 1, created_at: date)
    .group(:created_at)
  end
end
