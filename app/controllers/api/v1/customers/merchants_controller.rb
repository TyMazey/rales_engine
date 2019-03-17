class Api::V1::Customers::MerchantsController < ApplicationController

  def show
    render json: MerchantSerializer.new(Customer.favorite_merchant(params[:id])[0])
  end
end
