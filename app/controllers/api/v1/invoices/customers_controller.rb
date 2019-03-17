class Api::V1::Invoices::CustomersController < ApplicationController

  def show
    render json: InvoiceCustomerSerializer.new(Invoice.find(params[:id]))
  end
end
