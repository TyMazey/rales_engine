class Customer < ApplicationRecord

  has_many :invoices
  has_many :transactions, through: :invoices

  def self.favorite_merchant(id, limit= 1)
    Merchant.select("merchants.*, count(transactions) AS total_transactions")
    .joins(invoices: :transactions)
    .where(invoices: {customer_id: id}, transactions: {result: 1})
    .group(:id)
    .order("total_transactions DESC")
    .limit(limit)
  end
end
