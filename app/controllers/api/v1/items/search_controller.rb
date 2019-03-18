class Api::V1::Items::SearchController < ApplicationController

  def show
    render json: ItemSerializer.new(Item.find_by(item_params)) unless item_params[:unit_price]
    if item_params[:unit_price]
      price = item_params[:unit_price].gsub(".", "")
      render json: ItemSerializer.new(Item.find_by(unit_price: price))
    end
  end

  def index
    render json: ItemSerializer.new(Item.where(item_params)) unless item_params[:unit_price]
    if item_params[:unit_price]
      price = item_params[:unit_price].gsub(".", "")
      render json: ItemSerializer.new(Item.where(unit_price: price))
    end
  end

  private
  def item_params
    params.permit(:id, :name, :description, :unit_price, :merchant_id, :created_at, :updated_at)
  end
end
