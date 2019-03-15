class Api::V1::Merchants::RevenueController < ApplicationController

  def index
    render json: MerchantSerializer.new(Merchant.most_revenue(params[:quantity]))
  end

  def show
    render json: TotalRevenueSerializer.new(Transaction.revenue_for_date(params[:date])[0])
  end
end
