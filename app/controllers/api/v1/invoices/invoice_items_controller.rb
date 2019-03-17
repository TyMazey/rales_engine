class Api::V1::Invoices::InvoiceItemsController < ApplicationController

  def show
    render json: InvoiceInvoiceItemsSerializer.new(Invoice.find(params[:id]))
  end
end
