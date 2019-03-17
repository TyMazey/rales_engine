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

  def self.most_items_sold(limit = 1)
    select("items.*, sum(invoice_items.quantity) AS total_sold")
    .joins(invoice_items: {invoice: :transactions})
    .where(transactions: {result: 1})
    .group(:id)
    .order("total_sold DESC")
    .limit(limit)
  end

  def self.best_day(id, limit = 1)
    Invoice.select("invoices.created_at AS best_day, sum(invoice_items.quantity * invoice_items.unit_price) AS revenue")
    .joins(:transactions, :invoice_items)
    .where(invoice_items: {item_id: id}, transactions: {result: 1})
    .group(:created_at)
    .order("revenue")
    .limit(limit)
  end
end
