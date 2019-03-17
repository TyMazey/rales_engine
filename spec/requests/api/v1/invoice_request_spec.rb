require 'rails_helper'

describe 'invoices API ' do

  it 'sends a list of invoices' do
    cust = create(:customer).id
    merch = create(:merchant).id
    create(:invoice, merchant_id: merch, customer_id: cust)
    create(:invoice, merchant_id: merch, customer_id: cust)
    create(:invoice, merchant_id: merch, customer_id: cust)


    get '/api/v1/invoices'

    expect(response).to be_successful
    invoices = JSON.parse(response.body)
    expect(invoices["data"].count).to eq(3)
  end

  it 'can get a single invoice by its id' do
    cust = create(:customer).id
    merch = create(:merchant).id
    id = create(:invoice, merchant_id: merch, customer_id: cust).id.to_s

    get "/api/v1/invoices/#{id}"

    json = JSON.parse(response.body)

    expect(response).to be_successful
    expect(json['data']['id']).to eq(id)
  end

  it 'can find a invoice by id paramaters' do
    cust = create(:customer).id
    merch = create(:merchant).id
    id = create(:invoice, merchant_id: merch, customer_id: cust).id

    get "/api/v1/invoices/find?id=#{id}"

    json = JSON.parse(response.body)

    expect(response).to be_successful
    expect(json["data"]["attributes"]["id"]).to eq(id)
  end

  it 'can find a invoice by customer_id paramaters' do
    cust = create(:customer).id
    merch = create(:merchant).id
    id = create(:invoice, merchant_id: merch, customer_id: cust).id

    get "/api/v1/invoices/find?customer_id=#{cust}"

    json = JSON.parse(response.body)

    expect(response).to be_successful
    expect(json["data"]["attributes"]["customer_id"]).to eq(cust)
  end

  it 'can find a invoice by merchant_id paramaters' do
    cust = create(:customer).id
    merch = create(:merchant).id
    id = create(:invoice, merchant_id: merch, customer_id: cust).id

    get "/api/v1/invoices/find?merchant_id=#{merch}"

    json = JSON.parse(response.body)

    expect(response).to be_successful
    expect(json["data"]["attributes"]["merchant_id"]).to eq(merch)
  end

  it 'can find a invoice by status paramaters' do
    cust = create(:customer).id
    merch = create(:merchant).id
    id = create(:invoice, merchant_id: merch, customer_id: cust).id

    get "/api/v1/invoices/find?status=shipped"

    json = JSON.parse(response.body)

    expect(response).to be_successful
    expect(json["data"]["attributes"]["status"]).to eq("shipped")
  end

  it 'can find a invoice by created_at paramaters' do
    date = "2012-03-27 14:56:04 UTC"
    cust = create(:customer).id
    merch = create(:merchant).id
    id = create(:invoice, merchant_id: merch, customer_id: cust, created_at: date).id

    get "/api/v1/invoices/find?created_at=#{date}"

    json = JSON.parse(response.body)

    expect(response).to be_successful
    expect(json["data"]["attributes"]["created_at"]).to eq("2012-03-27T14:56:04.000Z")
  end

  it 'can find a invoice by created_at paramaters' do
    date = "2012-03-27 14:56:04 UTC"
    cust = create(:customer).id
    merch = create(:merchant).id
    id = create(:invoice, merchant_id: merch, customer_id: cust, updated_at: date).id

    get "/api/v1/invoices/find?updated_at=#{date}"

    json = JSON.parse(response.body)

    expect(response).to be_successful
    expect(json["data"]["attributes"]["updated_at"]).to eq("2012-03-27T14:56:04.000Z")
  end

  it 'can find all invoices by matching paramaters' do
    date = "2012-03-27 14:56:04 UTC"
    cust = create(:customer).id
    cust_2 = create(:customer).id
    merch = create(:merchant).id
    merch_2 = create(:merchant).id
    create(:invoice, merchant_id: merch, customer_id: cust, updated_at: date, created_at: date)
    create(:invoice, merchant_id: merch, customer_id: cust, updated_at: date, created_at: date)
    create(:invoice, merchant_id: merch, customer_id: cust, updated_at: date, created_at: date)
    create(:invoice, merchant_id: merch_2, customer_id: cust_2, status: 0)

    get "/api/v1/invoices/find_all?merchant_id=#{merch}"
    json = JSON.parse(response.body)
    expect(json["data"].count).to eq(3)

    get "/api/v1/invoices/find_all?customer_id=#{cust}"
    json = JSON.parse(response.body)
    expect(json["data"].count).to eq(3)

    get "/api/v1/invoices/find_all?status=shipped"
    json = JSON.parse(response.body)
    expect(json["data"].count).to eq(3)

    get "/api/v1/invoices/find_all?created_at=#{date}"
    json = JSON.parse(response.body)
    expect(json["data"].count).to eq(3)

    get "/api/v1/invoices/find_all?updated_at=#{date}"
    json = JSON.parse(response.body)
    expect(json["data"].count).to eq(3)
  end

  it 'can return random' do
    cust = create(:customer).id
    merch = create(:merchant).id
    one = create(:invoice, merchant_id: merch, customer_id: cust).id
    two = create(:invoice, merchant_id: merch, customer_id: cust).id
    three = create(:invoice, merchant_id: merch, customer_id: cust).id

    get "/api/v1/invoices/random"
    json = JSON.parse(response.body)
    expect(json["data"]["attributes"]["id"]).to eq(one).or eq(two).or eq(three)
  end

  it 'can return relationships for an invoice' do
    cust = create(:customer).id.to_s
    merch = create(:merchant).id.to_s
    invoice = create(:invoice, merchant_id: merch, customer_id: cust).id
    create(:transaction, invoice_id: invoice)
    item = create(:item, merchant_id: merch).id
    create(:invoice_item, invoice_id: invoice, item_id: item)

    get "/api/v1/invoices/#{invoice}/transactions"
    json = JSON.parse(response.body)
    expect(json["data"]["relationships"]["transactions"]["data"].count).to eq(1)

    get "/api/v1/invoices/#{invoice}/customers"
    json = JSON.parse(response.body)
    expect(json["data"]["relationships"]["customer"]["data"]["id"]).to eq(cust)

    get "/api/v1/invoices/#{invoice}/merchants"
    json = JSON.parse(response.body)
    expect(json["data"]["relationships"]["merchant"]["data"]["id"]).to eq(merch)

    get "/api/v1/invoices/#{invoice}/invoice_items"
    json = JSON.parse(response.body)
    expect(json["data"]["relationships"]["invoice_items"]["data"].count).to eq(1)

    get "/api/v1/invoices/#{invoice}/items"
    json = JSON.parse(response.body)
    expect(json["data"]["relationships"]["items"]["data"].count).to eq(1)
  end
end
