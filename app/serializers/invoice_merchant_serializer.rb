class InvoiceMerchantSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :customer_id, :merchant_id, :status, :created_at, :updated_at
  belongs_to :merchant
end
