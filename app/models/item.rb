class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  def self.most_revenue(limit = 1)
    select("items.*, sum(invoice_items.quantity * invoice_items.unit_price) AS revenue")
    .joins(invoice_items: {invoice: :transactions})
    .where(transactions: {result: 1})
    .group(:id)
    .order("revenue DESC")
    .limit(limit)
  end
end
