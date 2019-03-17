describe 'items API ' do

  it 'sends a list of transactions' do
    cust = create(:customer).id
    merch = create(:merchant).id
    invo = create(:invoice, merchant_id: merch, customer_id: cust).id
    create(:transaction, invoice_id: invo)
    create(:transaction, invoice_id: invo)
    create(:transaction, invoice_id: invo)

    get '/api/v1/transactions'

    expect(response).to be_successful
    invoices = JSON.parse(response.body)
    expect(invoices["data"].count).to eq(3)
  end

  it 'can get a single transaction by its id' do
    cust = create(:customer).id
    merch = create(:merchant).id
    invo = create(:invoice, merchant_id: merch, customer_id: cust).id
    id = create(:transaction, invoice_id: invo).id.to_s

    get "/api/v1/transactions/#{id}"

    json = JSON.parse(response.body)

    expect(response).to be_successful
    expect(json['data']['id']).to eq(id)
  end

  it 'can find transactions by attributes as params' do
    date = "2012-03-27 14:56:04 UTC"
    cust = create(:customer).id
    merch = create(:merchant).id
    invo = create(:invoice, merchant_id: merch, customer_id: cust).id
    id = create(:transaction, invoice_id: invo, credit_card_number: 1, credit_card_expiration_date: 1, created_at: date, updated_at: date).id

    get "/api/v1/transactions/find?id=#{id}"
    json = JSON.parse(response.body)
    expect(json['data']["attributes"]['id']).to eq(id)

    get "/api/v1/transactions/find?invoice_id=#{invo}"
    json = JSON.parse(response.body)
    expect(json['data']["attributes"]['invoice_id']).to eq(invo)

    get "/api/v1/transactions/find?credit_card_number=1"
    json = JSON.parse(response.body)
    expect(json['data']["attributes"]['credit_card_number']).to eq(1)

    get "/api/v1/transactions/find?credit_card_expiration_date=1"
    json = JSON.parse(response.body)
    expect(json['data']["attributes"]['credit_card_expiration_date']).to eq(1)

    get "/api/v1/transactions/find?result=success"
    json = JSON.parse(response.body)
    expect(json['data']["attributes"]['result']).to eq("success")

    get "/api/v1/transactions/find?created_at=#{date}"
    json = JSON.parse(response.body)
    expect(json['data']["attributes"]['created_at']).to eq("2012-03-27T14:56:04.000Z")

    get "/api/v1/transactions/find?updated_at=#{date}"
    json = JSON.parse(response.body)
    expect(json['data']["attributes"]['updated_at']).to eq("2012-03-27T14:56:04.000Z")
  end

  it 'can find all transactions by attributes as params' do
    date = "2012-03-27 14:56:04 UTC"
    cust = create(:customer).id
    merch = create(:merchant).id
    invo = create(:invoice, merchant_id: merch, customer_id: cust).id
    invo_2 = create(:invoice, merchant_id: merch, customer_id: cust).id
    create(:transaction, invoice_id: invo, credit_card_number: 1, credit_card_expiration_date: 1, created_at: date, updated_at: date)
    create(:transaction, invoice_id: invo, credit_card_number: 1, credit_card_expiration_date: 1, created_at: date, updated_at: date)
    create(:transaction, invoice_id: invo, credit_card_number: 1, credit_card_expiration_date: 1, created_at: date, updated_at: date)
    create(:transaction, invoice_id: invo_2, credit_card_number: 2, credit_card_expiration_date: 2, result: 0)

    get "/api/v1/transactions/find_all?invoice_id=#{invo}"
    json = JSON.parse(response.body)
    expect(json["data"].count).to eq(3)

    get "/api/v1/transactions/find_all?credit_card_number=1"
    json = JSON.parse(response.body)
    expect(json["data"].count).to eq(3)

    get "/api/v1/transactions/find_all?credit_card_expiration_date=1"
    json = JSON.parse(response.body)
    expect(json["data"].count).to eq(3)

    get "/api/v1/transactions/find_all?result=success"
    json = JSON.parse(response.body)
    expect(json["data"].count).to eq(3)

    get "/api/v1/transactions/find_all?created_at=#{date}"
    json = JSON.parse(response.body)
    expect(json["data"].count).to eq(3)

    get "/api/v1/transactions/find_all?updated_at=#{date}"
    json = JSON.parse(response.body)
    expect(json["data"].count).to eq(3)
  end

  it 'can find random transaction' do
    date = "2012-03-27 14:56:04 UTC"
    cust = create(:customer).id
    merch = create(:merchant).id
    invo = create(:invoice, merchant_id: merch, customer_id: cust).id
    one = create(:transaction, invoice_id: invo, credit_card_number: 1, credit_card_expiration_date: 1, created_at: date, updated_at: date).id
    two = create(:transaction, invoice_id: invo, credit_card_number: 1, credit_card_expiration_date: 1, created_at: date, updated_at: date).id
    three = create(:transaction, invoice_id: invo, credit_card_number: 1, credit_card_expiration_date: 1, created_at: date, updated_at: date).id

    get "/api/v1/transactions/random"
    json = JSON.parse(response.body)
    expect(json["data"]["attributes"]["id"]).to eq(one).or eq(two).or eq(three)
  end
end
