class Api::V1::Merchants::CustomersController < ApplicationController

  def show
    render json: CustomerSerializer.new(Merchant.favorite_customer(params[:id])[0])
  end
end
