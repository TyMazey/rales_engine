class Api::V1::Customers::InvoicesController < ApplicationController

  def show
    render json: CustomerInvoicesSerializer.new(Customer.find(params[:id]))
  end
end
