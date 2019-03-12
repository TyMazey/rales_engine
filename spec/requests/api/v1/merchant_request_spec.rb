require 'rails_helper'

describe 'Merchants Api' do

  it 'sends a list of merchants' do
    create_list(:merchant, 3)

    get '/api/v1/merchants'

    expect(response).to be_successful
    merchants = JSON.parse(response.body)
    expect(merchants["data"].count).to eq(3)
  end

  it 'can get a single merchant by its id' do
    id = create(:merchant).id.to_s

    get "/api/v1/merchants/#{id}"

    merchant = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchant['data']['id']).to eq(id)
  end

  it 'can find a merchant by id paramaters' do
    id = create(:merchant).id

    get "/api/v1/merchants/find?id=#{id}"

    merchant = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchant["data"]["attributes"]["id"]).to eq(id)
  end

  it 'can find a merchant by name paramaters' do
    name = create(:merchant).name

    get "/api/v1/merchants/find?name=#{name}"

    merchant = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchant["data"]["attributes"]["name"]).to eq(name)
  end

  it 'can find a merchant by created_at paramaters' do
    date = "2012-03-27 14:56:04 UTC"
    create(:merchant, created_at: date)

    get "/api/v1/merchants/find?created_at=#{date}"

    merchant = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchant["data"]["attributes"]["created_at"]).to eq("2012-03-27T14:56:04.000Z")
  end

  it 'can find a merchant by updated_at paramaters' do
    date = "2012-03-27 14:56:04 UTC"
    create(:merchant, updated_at: date)

    get "/api/v1/merchants/find?updated_at=#{date}"

    merchant = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchant["data"]["attributes"]["updated_at"]).to eq("2012-03-27T14:56:04.000Z")
  end

  it 'can find all merchants with matching search' do
    date = "2012-03-27 14:56:04 UTC"
    create(:merchant, name: 'merchant', created_at: date, updated_at: date)
    create(:merchant, name: 'merchant', created_at: date, updated_at: date)
    create(:merchant, name: 'merchant', created_at: date, updated_at: date)
    create(:merchant)

    get "/api/v1/merchants/find_all?name=merchant"
    merchants = JSON.parse(response.body)
    expect(merchants["data"].count).to eq(3)

    get "/api/v1/merchants/find_all?created_at=#{date}"
    merchants = JSON.parse(response.body)
    expect(merchants["data"].count).to eq(3)

    get "/api/v1/merchants/find_all?updated_at=#{date}"
    merchants = JSON.parse(response.body)
    expect(merchants["data"].count).to eq(3)
  end
end
