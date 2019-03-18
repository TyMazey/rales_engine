class Api::V1::InvoiceItems::SearchController < ApplicationController

  def show
    render json: InvoiceItemSerializer.new(InvoiceItem.find_by(invoice_item_params)) unless invoice_item_params[:unit_price]
    if invoice_item_params[:unit_price]
      price = invoice_item_params[:unit_price].gsub(".", "")
      render json: ItemSerializer.new(Item.find_by(unit_price: price))
    end
  end

  def index
    render json: InvoiceItemSerializer.new(InvoiceItem.where(invoice_item_params)) unless invoice_item_params[:unit_price]
    if invoice_item_params[:unit_price]
      price = invoice_item_params[:unit_price].gsub(".", "")
      render json: InvoiceItemSerializer.new(InvoiceItem.where(unit_price: price))
    end
  end

  private
  def invoice_item_params
    params.permit(:id, :item_id, :invoice_id, :quantity, :unit_price, :created_at, :updated_at)
  end
end
