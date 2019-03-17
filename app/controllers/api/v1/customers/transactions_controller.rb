class Api::V1::Customers::TransactionsController < ApplicationController

  def show
    render json: CustomerTransactionsSerializer.new(Customer.find(params[:id]))
  end
end
