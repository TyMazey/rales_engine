require 'rails_helper'

describe 'Merchants Api' do
  before(:each) do
    @date_1 = "2012-03-27 14:56:04 UTC"
    @date_2 = "2012-04-27 14:56:04 UTC"
    @customer = create(:customer)
    @merch_one = create(:merchant)
    @item_1 = create(:item, merchant: @merch_one)
    @merch_two = create(:merchant)
    @item_2 = create(:item, merchant: @merch_two)
    @merch_three = create(:merchant)
    @item_3 = create(:item, merchant: @merch_three)
    invoice_1 = create(:invoice, customer: @customer, merchant: @merch_one, created_at: @date_1)
    transaction_1 = create(:transaction, invoice: invoice_1, created_at: @date_1)
    invoice_2 = create(:invoice, customer: @customer, merchant: @merch_two, created_at: @date_1)
    transaction_2 = create(:transaction, invoice: invoice_2, created_at: @date_1)
    invoice_3 = create(:invoice, customer: @customer, merchant: @merch_three, created_at: @date_1)
    transaction_3 = create(:transaction, invoice: invoice_3, created_at: @date_2)
    invoice_4 = create(:invoice, customer: @customer, merchant: @merch_three, created_at: @date_2)
    transaction_4 = create(:transaction, invoice: invoice_4, created_at: @date_2)
    invoice_5 = create(:invoice, customer: @customer, merchant: @merch_three, created_at: @date_1)
    transaction_5 = create(:transaction, invoice: invoice_4, created_at: @date_2, result: 0)
    invoice_item_1 = create(:invoice_item, item: @item_1, invoice: invoice_1, quantity: 2)
    invoice_item_2 = create(:invoice_item, item: @item_2, invoice: invoice_2)
    invoice_item_3 = create(:invoice_item, item: @item_3, invoice: invoice_3, quantity: 2)
    invoice_item_4 = create(:invoice_item, item: @item_3, invoice: invoice_4, unit_price: 4)
  end

  it 'can return top items by revenue' do

    get "/api/v1/items/most_revenue?quantity=2"
    json = JSON.parse(response.body)

    expect(json["data"].count).to eq(2)
    expect(json["data"][0]["attributes"]["id"]).to eq(@item_3.id)
    expect(json["data"][1]["attributes"]["id"]).to eq(@item_1.id)
  end

  it 'can return top items by amount sold' do

    get "/api/v1/items/most_items?quantity=2"
    json = JSON.parse(response.body)

    expect(json["data"].count).to eq(2)
    expect(json["data"][0]["attributes"]["id"]).to eq(@item_3.id)
    expect(json["data"][1]["attributes"]["id"]).to eq(@item_1.id)
  end

  it 'can return the best day for revenue for an item' do

    get "/api/v1/items/#{@item_3.id}/best_day"
    json = JSON.parse(response.body)

    expect(json["data"]["attributes"]["best_day"]).to eq("2012-03-27")
  end
end
