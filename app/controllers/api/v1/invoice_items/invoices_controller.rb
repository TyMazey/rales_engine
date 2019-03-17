class Api::V1::InvoiceItems::InvoicesController < ApplicationController

  def show
    render json: InvoiceItemInvoiceSerializer.new(InvoiceItem.find(params[:id]))
  end
end
