class Api::V1::Invoices::ItemsController < ApplicationController

  def show
    render json: ItemSerializer.new(Invoice.find(params[:id]).items)
  end
end
