class Api::V1::InvoiceItems::ItemsController < ApplicationController

  def show
    render json: InvoiceItemItemSerializer.new(InvoiceItem.find(params[:id]))
  end
end
