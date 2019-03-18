class Api::V1::Merchants::RevenueDateController < ApplicationController

  def show
    render json: TotalRevenueSerializer.new(Merchant.revenue_for_date(params[:date])[0])
  end
end
