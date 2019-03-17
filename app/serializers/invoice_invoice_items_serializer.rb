class InvoiceInvoiceItemsSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :customer_id, :merchant_id, :status, :created_at, :updated_at
  has_many :invoice_items
end
