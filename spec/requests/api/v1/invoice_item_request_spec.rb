require 'rails_helper'

describe 'invoice items API ' do

  it 'sends a list of invoice items' do
    cust = create(:customer).id
    merch = create(:merchant).id
    item = create(:item, merchant_id: merch).id
    invo = create(:invoice, merchant_id: merch, customer_id: cust).id
    create(:invoice_item, item_id: item, invoice_id: invo)
    create(:invoice_item, item_id: item, invoice_id: invo)
    create(:invoice_item, item_id: item, invoice_id: invo)


    get '/api/v1/invoice_items'

    expect(response).to be_successful
    invoices = JSON.parse(response.body)
    expect(invoices["data"].count).to eq(3)
  end

  it 'can get a single invoice item by its id' do
    cust = create(:customer).id
    merch = create(:merchant).id
    item = create(:item, merchant_id: merch).id
    invo = create(:invoice, merchant_id: merch, customer_id: cust).id
    id  = create(:invoice_item, item_id: item, invoice_id: invo).id.to_s

    get "/api/v1/invoice_items/#{id}"

    json = JSON.parse(response.body)

    expect(response).to be_successful
    expect(json['data']['id']).to eq(id)
  end

  it 'can find a invoice item by attributes as paramaters' do
    date = "2012-03-27 14:56:04 UTC"
    cust = create(:customer).id
    merch = create(:merchant).id
    item = create(:item, merchant_id: merch).id
    invo = create(:invoice, merchant_id: merch, customer_id: cust).id
    id  = create(:invoice_item, item_id: item, invoice_id: invo, quantity: 10, unit_price: 10, created_at: date, updated_at: date).id

    get "/api/v1/invoice_items/find?id=#{id}"
    json = JSON.parse(response.body)
    expect(response).to be_successful
    expect(json["data"]["attributes"]["id"]).to eq(id)

    get "/api/v1/invoice_items/find?item_id=#{item}"
    json = JSON.parse(response.body)
    expect(response).to be_successful
    expect(json["data"]["attributes"]["item_id"]).to eq(item)

    get "/api/v1/invoice_items/find?invoice_id=#{invo}"
    json = JSON.parse(response.body)
    expect(response).to be_successful
    expect(json["data"]["attributes"]["invoice_id"]).to eq(invo)

    get "/api/v1/invoice_items/find?quantity=10"
    json = JSON.parse(response.body)
    expect(response).to be_successful
    expect(json["data"]["attributes"]["quantity"]).to eq(10)

    get "/api/v1/invoice_items/find?unit_price=10"
    json = JSON.parse(response.body)
    expect(response).to be_successful
    expect(json["data"]["attributes"]["unit_price"]).to eq(10)

    get "/api/v1/invoice_items/find?created_at=#{date}"
    json = JSON.parse(response.body)
    expect(response).to be_successful
    expect(json["data"]["attributes"]["created_at"]).to eq("2012-03-27T14:56:04.000Z")

    get "/api/v1/invoice_items/find?updated_at=#{date}"
    json = JSON.parse(response.body)
    expect(response).to be_successful
    expect(json["data"]["attributes"]["updated_at"]).to eq("2012-03-27T14:56:04.000Z")
  end

  it 'can find all invoice items by attributes as paramaters' do
    date = "2012-03-27 14:56:04 UTC"
    cust = create(:customer).id
    merch = create(:merchant).id
    item = create(:item, merchant_id: merch).id
    item_2 = create(:item, merchant_id: merch).id
    invo = create(:invoice, merchant_id: merch, customer_id: cust).id
    invo_2 = create(:invoice, merchant_id: merch, customer_id: cust).id
    create(:invoice_item, item_id: item, invoice_id: invo, quantity: 10, unit_price: 10, created_at: date, updated_at: date)
    create(:invoice_item, item_id: item, invoice_id: invo, quantity: 10, unit_price: 10, created_at: date, updated_at: date)
    create(:invoice_item, item_id: item, invoice_id: invo, quantity: 10, unit_price: 10, created_at: date, updated_at: date)
    create(:invoice_item, item_id: item_2, invoice_id: invo_2, quantity: 100, unit_price: 100)

    get "/api/v1/invoice_items/find_all?item_id=#{item}"
    json = JSON.parse(response.body)
    expect(json["data"].count).to eq(3)

    get "/api/v1/invoice_items/find_all?invoice_id=#{invo}"
    json = JSON.parse(response.body)
    expect(json["data"].count).to eq(3)

    get "/api/v1/invoice_items/find_all?quantity=10"
    json = JSON.parse(response.body)
    expect(json["data"].count).to eq(3)

    get "/api/v1/invoice_items/find_all?unit_price=10"
    json = JSON.parse(response.body)
    expect(json["data"].count).to eq(3)

    get "/api/v1/invoice_items/find_all?created_at=#{date}"
    json = JSON.parse(response.body)
    expect(json["data"].count).to eq(3)

    get "/api/v1/invoice_items/find_all?updated_at=#{date}"
    json = JSON.parse(response.body)
    expect(json["data"].count).to eq(3)
  end

  it 'can return random' do
    cust = create(:customer).id
    merch = create(:merchant).id
    item = create(:item, merchant_id: merch).id
    invo = create(:invoice, merchant_id: merch, customer_id: cust).id
    one = create(:invoice_item, item_id: item, invoice_id: invo, quantity: 10, unit_price: 10).id
    two = create(:invoice_item, item_id: item, invoice_id: invo, quantity: 10, unit_price: 10).id
    three = create(:invoice_item, item_id: item, invoice_id: invo, quantity: 10, unit_price: 10).id

    get "/api/v1/invoice_items/random"
    json = JSON.parse(response.body)
    expect(json["data"]["attributes"]["id"]).to eq(one).or eq(two).or eq(three)
  end

  it 'can return relationships for invoice items' do
    cust = create(:customer).id
    merch = create(:merchant).id
    item = create(:item, merchant_id: merch).id.to_s
    invo = create(:invoice, merchant_id: merch, customer_id: cust).id.to_s
    id = create(:invoice_item, item_id: item, invoice_id: invo, quantity: 10, unit_price: 10).id

    get "/api/v1/invoice_items/#{id}/invoice"
    json = JSON.parse(response.body)
    expect(json["data"]["relationships"]["invoice"]["data"]["id"]).to eq(invo)

    get "/api/v1/invoice_items/#{id}/item"
    json = JSON.parse(response.body)
    expect(json["data"]["relationships"]["item"]["data"]["id"]).to eq(item)
  end
end
