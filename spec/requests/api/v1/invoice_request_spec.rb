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

  it 'can get a single merchant by its id' do
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
end
