require 'rails_helper'

describe 'Merchants Api' do
  before(:each) do
    @date_1 = "2012-03-27 14:56:04 UTC"
    date_2 = "2012-04-27 14:56:04 UTC"
    customer = create(:customer)
    @merch_one = create(:merchant)
    item_1 = create(:item, merchant: @merch_one)
    @merch_two = create(:merchant)
    item_2 = create(:item, merchant: @merch_two)
    @merch_three = create(:merchant)
    item_3 = create(:item, merchant: @merch_three)
    invoice_1 = create(:invoice, customer: customer, merchant: @merch_one)
    transaction_1 = create(:transaction, invoice: invoice_1, created_at: @date_1)
    invoice_2 = create(:invoice, customer: customer, merchant: @merch_two)
    transaction_2 = create(:transaction, invoice: invoice_2, created_at: @date_1)
    invoice_3 = create(:invoice, customer: customer, merchant: @merch_three)
    transaction_3 = create(:transaction, invoice: invoice_3, created_at: date_2)
    invoice_4 = create(:invoice, customer: customer, merchant: @merch_three)
    transaction_4 = create(:transaction, invoice: invoice_4, created_at: date_2)
    invoice_item_1 = create(:invoice_item, item: item_1, invoice: invoice_1, quantity: 2)
    invoice_item_2 = create(:invoice_item, item: item_2, invoice: invoice_2)
    invoice_item_3 = create(:invoice_item, item: item_3, invoice: invoice_3, quantity: 2)
    invoice_item_4 = create(:invoice_item, item: item_3, invoice: invoice_4, unit_price: 4)
  end

  it 'can return a top merchants by revenue' do

    get "/api/v1/merchants/most_revenue?quantity=2"
    merchants = JSON.parse(response.body)

    expect(merchants["data"].count).to eq(2)
    expect(merchants["data"][0]["attributes"]["id"]).to eq(@merch_three.id)
    expect(merchants["data"][1]["attributes"]["id"]).to eq(@merch_one.id)
  end

  it 'can return a top merchants by revenue' do

    get "/api/v1/merchants/most_items?quantity=2"
    merchants = JSON.parse(response.body)

    expect(merchants["data"].count).to eq(2)
    expect(merchants["data"][0]["attributes"]["id"]).to eq(@merch_three.id)
    expect(merchants["data"][1]["attributes"]["id"]).to eq(@merch_one.id)
  end

  it 'can return a total revenue for a date' do

    get "/api/v1/merchants/revenue?date=#{@date_1}"
    json = JSON.parse(response.body)
    expected = {"total_revenue" => 58}

    expect(json["data"]["attributes"]).to eq(expected)
  end

  it 'can return a total revenue for a date' do

    get "/api/v1/merchants/#{@merch_one.id}/revenue"
    json = JSON.parse(response.body)
    expected = {"revenue" => 44}

    expect(json["data"]["attributes"]).to eq(expected)
  end
end
