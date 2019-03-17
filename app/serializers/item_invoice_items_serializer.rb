class ItemInvoiceItemsSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name, :description, :unit_price, :merchant_id, :created_at, :updated_at
  has_many :invoice_items
end
