class Api::V1::Invoices::ItemsController < ApplicationController

  def show
    render json: InvoiceItemsSerializer.new(Invoice.find(params[:id]))
  end
end
