class Api::V1::Items::MerchantsController < ApplicationController

  def show
    render json: ItemMerchantSerializer.new(Item.find(params[:id]))
  end
end
