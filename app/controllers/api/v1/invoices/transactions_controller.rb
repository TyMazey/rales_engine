class Api::V1::Invoices::TransactionsController < ApplicationController

  def show
    render json: InvoiceTransactionsSerializer.new(Invoice.find(params[:id]))
  end
end
