class Api::V1::Transactions::InvoicesController < ApplicationController

  def show
    render json: TransactionInvoiceSerializer.new(Transaction.find(params[:id]))
  end
end
