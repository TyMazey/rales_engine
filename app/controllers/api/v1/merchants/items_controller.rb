class Api::V1::Merchants::ItemsController < ApplicationController

  def index
    render json: MerchantSerializer.new(Merchant.most_items(params[:quantity]))
  end

  def show
    render json: ItemSerializer.new(Merchant.find(params[:id]).items)
  end
end
