describe 'items API ' do

  it 'sends a list of items' do
    merch = create(:merchant).id
    create(:item, merchant_id: merch)
    create(:item, merchant_id: merch)
    create(:item, merchant_id: merch)

    get '/api/v1/items'

    expect(response).to be_successful
    invoices = JSON.parse(response.body)
    expect(invoices["data"].count).to eq(3)
  end

  it 'can get a single invoice item by its id' do
    merch = create(:merchant).id
    id = create(:item, merchant_id: merch).id.to_s

    get "/api/v1/items/#{id}"

    json = JSON.parse(response.body)

    expect(response).to be_successful
    expect(json['data']['id']).to eq(id)
  end

  it 'can find item by attributes as paramaters' do
    date = "2012-03-27 14:56:04 UTC"
    merch = create(:merchant).id
    id = create(:item, name: "name", description: "descript", unit_price: 10, merchant_id: merch, created_at: date, updated_at: date).id

    get "/api/v1/items/find?id=#{id}"
    json = JSON.parse(response.body)
    expect(response).to be_successful
    expect(json["data"]["attributes"]["id"]).to eq(id)

    get "/api/v1/items/find?name=name"
    json = JSON.parse(response.body)
    expect(response).to be_successful
    expect(json["data"]["attributes"]["name"]).to eq("name")

    get "/api/v1/items/find?description=descript"
    json = JSON.parse(response.body)
    expect(response).to be_successful
    expect(json["data"]["attributes"]["description"]).to eq("descript")

    get "/api/v1/items/find?unit_price=10"
    json = JSON.parse(response.body)
    expect(response).to be_successful
    expect(json["data"]["attributes"]["unit_price"]).to eq(10)

    get "/api/v1/items/find?merchant_id=#{merch}"
    json = JSON.parse(response.body)
    expect(response).to be_successful
    expect(json["data"]["attributes"]["merchant_id"]).to eq(merch)

    get "/api/v1/items/find?created_at=#{date}"
    json = JSON.parse(response.body)
    expect(response).to be_successful
    expect(json["data"]["attributes"]["created_at"]).to eq("2012-03-27T14:56:04.000Z")

    get "/api/v1/items/find?updated_at=#{date}"
    json = JSON.parse(response.body)
    expect(response).to be_successful
    expect(json["data"]["attributes"]["updated_at"]).to eq("2012-03-27T14:56:04.000Z")
  end

  it 'can find all items by attributes as paramaters' do
    date = "2012-03-27 14:56:04 UTC"
    merch = create(:merchant).id
    merch_2 = create(:merchant).id
    create(:item, name: "name", description: "descript", unit_price: 10, merchant_id: merch, created_at: date, updated_at: date).id
    create(:item, name: "name", description: "descript", unit_price: 10, merchant_id: merch, created_at: date, updated_at: date).id
    create(:item, name: "name", description: "descript", unit_price: 10, merchant_id: merch, created_at: date, updated_at: date).id
    create(:item, name: "not name", description: "not descript", unit_price: 100, merchant_id: merch_2).id

    get "/api/v1/items/find_all?name=name"
    json = JSON.parse(response.body)
    expect(json["data"].count).to eq(3)

    get "/api/v1/items/find_all?description=descript"
    json = JSON.parse(response.body)
    expect(json["data"].count).to eq(3)

    get "/api/v1/items/find_all?unit_price=10"
    json = JSON.parse(response.body)
    expect(json["data"].count).to eq(3)

    get "/api/v1/items/find_all?merchant_id=#{merch}"
    json = JSON.parse(response.body)
    expect(json["data"].count).to eq(3)

    get "/api/v1/items/find_all?created_at=#{date}"
    json = JSON.parse(response.body)
    expect(json["data"].count).to eq(3)

    get "/api/v1/items/find_all?updated_at=#{date}"
    json = JSON.parse(response.body)
    expect(json["data"].count).to eq(3)
  end

  it 'can find all items by attributes as paramaters' do
    merch = create(:merchant).id
    one = create(:item, name: "name", description: "descript", unit_price: 10, merchant_id: merch).id
    two =create(:item, name: "name", description: "descript", unit_price: 10, merchant_id: merch).id
    three = create(:item, name: "name", description: "descript", unit_price: 10, merchant_id: merch).id

    get "/api/v1/items/random"
    json = JSON.parse(response.body)
    expect(json["data"]["attributes"]["id"]).to eq(one).or eq(two).or eq(three)
  end
end
