class Api::V1::Merchants::InvoicesController < ApplicationController

  def show
    render json: InvoiceSerializer.new(Merchant.find(params[:id]).invoices)
  end
end
