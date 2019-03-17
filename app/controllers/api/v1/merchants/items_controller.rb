class Api::V1::Merchants::ItemsController < ApplicationController

  def index
    render json: MerchantSerializer.new(Merchant.most_items(params[:quantity]))
  end

  def show
    render json: MerchantItemsSerializer.new(Merchant.find(params[:id]))
  end
end
