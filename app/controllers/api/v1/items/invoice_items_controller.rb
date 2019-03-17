class Api::V1::Items::InvoiceItemsController < ApplicationController

  def show
    render json: ItemInvoiceItemsSerializer.new(Item.find(params[:id]))
  end
end
