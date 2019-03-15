class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices


  def self.most_revenue(limit)
    select("merchants.*, sum(invoice_items.quantity * invoice_items.unit_price) AS total_sold")
    .joins(invoices: [:invoice_items, :transactions])
    .where(transactions: {result: 1})
    .group(:id)
    .order("total_sold DESC")
    .limit(limit)
  end

  def self.most_items(limit)
    select("merchants.*, sum(invoice_items.quantity) AS total_items")
    .joins(invoices: [:invoice_items, :transactions])
    .where(transactions: {result: 1})
    .group(:id)
    .order("total_items DESC")
    .limit(limit)
  end

  def self.revenue_for_date(date)
    select("transactions.created_at AS date, sum(invoice_items.quantity * invoice_items.unit_price) AS total_revenue")
    .joins(:invoice_items, :transactions)
    .where(transactions: {result: 1, created_at: date})
    .group("transactions.created_at")
  end

  def total_revenue
    invoices.select("sum(invoice_items.quantity * invoice_items.unit_price) AS revenue")
    .joins(:invoice_items, :transactions)
    .where(transactions: {result: 1})
    .group(:merchant_id)
  end

  def total_revenue_for_date(date)
    invoices.select("sum(invoice_items.quantity * invoice_items.unit_price) AS revenue")
    .joins(:invoice_items, :transactions)
    .where(transactions: {result: 1, created_at: date})
    .group(:merchant_id)
  end
end
