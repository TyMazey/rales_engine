require 'rails_helper'

describe 'items API ' do

  it 'sends a list of customers' do
    create_list(:customer, 3)

    get '/api/v1/customers'

    expect(response).to be_successful
    invoices = JSON.parse(response.body)
    expect(invoices["data"].count).to eq(3)
  end

  it 'can get a single customer by its id' do
    id = create(:customer).id.to_s

    get "/api/v1/customers/#{id}"

    json = JSON.parse(response.body)

    expect(response).to be_successful
    expect(json['data']['id']).to eq(id)
  end

  it 'can find customers by attributes as params' do
    date = "2012-03-27 14:56:04 UTC"
    id = create(:customer, first_name: "name", last_name: "last", created_at: date, updated_at: date).id

    get "/api/v1/customers/find?id=#{id}"
    json = JSON.parse(response.body)
    expect(json['data']["attributes"]['id']).to eq(id)

    get "/api/v1/customers/find?first_name=name"
    json = JSON.parse(response.body)
    expect(json['data']["attributes"]['first_name']).to eq("name")

    get "/api/v1/customers/find?last_name=last"
    json = JSON.parse(response.body)
    expect(json['data']["attributes"]['last_name']).to eq("last")

    get "/api/v1/customers/find?created_at=#{date}"
    json = JSON.parse(response.body)
    expect(json['data']["attributes"]['created_at']).to eq("2012-03-27T14:56:04.000Z")

    get "/api/v1/customers/find?updated_at=#{date}"
    json = JSON.parse(response.body)
    expect(json['data']["attributes"]['updated_at']).to eq("2012-03-27T14:56:04.000Z")
  end

  it 'can find all customers by attributes as params' do
    date = "2012-03-27 14:56:04 UTC"
    create(:customer, first_name: "name", last_name: "last", created_at: date, updated_at: date)
    create(:customer, first_name: "name", last_name: "last", created_at: date, updated_at: date)
    create(:customer, first_name: "name", last_name: "last", created_at: date, updated_at: date)
    create(:customer, first_name: "not name", last_name: "not last")

    get "/api/v1/customers/find_all?first_name=name"
    json = JSON.parse(response.body)
    expect(json["data"].count).to eq(3)

    get "/api/v1/customers/find_all?last_name=last"
    json = JSON.parse(response.body)
    expect(json["data"].count).to eq(3)

    get "/api/v1/customers/find_all?created_at=#{date}"
    json = JSON.parse(response.body)
    expect(json["data"].count).to eq(3)

    get "/api/v1/customers/find_all?updated_at=#{date}"
    json = JSON.parse(response.body)
    expect(json["data"].count).to eq(3)
  end

  it 'can find random customer' do
    date = "2012-03-27 14:56:04 UTC"
    one = create(:customer).id
    two = create(:customer).id
    three = create(:customer).id

    get "/api/v1/customers/random"
    json = JSON.parse(response.body)
    expect(json["data"]["attributes"]["id"]).to eq(one).or eq(two).or eq(three)
  end
end
