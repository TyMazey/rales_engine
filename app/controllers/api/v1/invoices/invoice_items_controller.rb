class Api::V1::Invoices::InvoiceItemsController < ApplicationController

  def show
    render json: InvoiceItemSerializer.new(Invoice.find(params[:id]).invoice_items)
  end
end
