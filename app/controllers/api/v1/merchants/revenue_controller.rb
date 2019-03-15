class Api::V1::Merchants::RevenueController < ApplicationController

  def index
    render json: MerchantSerializer.new(Merchant.most_revenue(params[:quantity]))
  end

  def show
    merchant = Merchant.find(params[:id])
    render json: RevenueSerializer.new(merchant.total_revenue[0]) unless params["date"]
    if params["date"]
      render json: RevenueSerializer.new(merchant.total_revenue_for_date(params["date"])[0])
    end
  end
end
