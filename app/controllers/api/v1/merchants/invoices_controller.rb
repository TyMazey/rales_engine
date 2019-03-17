class Api::V1::Merchants::InvoicesController < ApplicationController

  def show
    render json: MerchantInvoicesSerializer.new(Merchant.find(params[:id]))
  end
end
