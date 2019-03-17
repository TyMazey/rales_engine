class InvoiceItemItemSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :item_id, :invoice_id, :quantity, :unit_price, :created_at, :updated_at
  belongs_to :item
end
