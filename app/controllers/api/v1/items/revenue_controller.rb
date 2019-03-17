class Api::V1::Items::RevenueController < ApplicationController

  def index
    render json: ItemSerializer.new(Item.most_revenue(params[:quantity]))
  end

  def show
    render json: ItemBestDaySerializer.new(Item.best_day(params[:id])[0])
  end
end
