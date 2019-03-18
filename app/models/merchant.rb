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
    Invoice.select("date_trunc('day', invoices.created_at) AS date, sum(invoice_items.quantity * invoice_items.unit_price) AS total_revenue")
    .joins(:invoice_items, :transactions)
    .where(transactions: {result: 1}, invoices: {created_at: Time.parse(date).utc.all_day})
    .group("date")
  end

  def self.favorite_customer(merch_id, limit = 1)
    Customer.select("customers.*, count(customers.id)")
    .joins(invoices: :transactions)
    .where(invoices: {merchant_id: merch_id}, transactions: {result: 1})
    .group(:id)
    .order("count DESC")
    .limit(limit)
  end

  def self.customers_with_pending_invoices
    Customer.select("customers.*")
    .joins(invoices: :transactions)
    .where(invoices: {merchant_id: merch_id}, transactions: {result: 0})
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
    .where(transactions: {result: 1}, invoices: {created_at: Time.parse(date).utc.all_day})
    .group(:merchant_id)
  end
end
