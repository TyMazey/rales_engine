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
    merchants = JSON.parse(response.body)
    expect(merchants["data"].count).to eq(3)
  end

  it 'can get a single merchant by its id' do
    cust = create(:customer).id
    merch = create(:merchant).id
    id = create(:invoice, merchant_id: merch, customer_id: cust).id.to_s

    get "/api/v1/invoices/#{id}"

    merchant = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchant['data']['id']).to eq(id)
  end
end
