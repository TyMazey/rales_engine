require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'relationships' do
    it { should have_many :items }
  end

  describe 'class methods' do
    before(:each) do
      @date_1 = "2012-03-27 14:56:04 UTC"
      date_2 = "2012-04-27 14:56:04 UTC"
      @customer = create(:customer)
      @merch_one = create(:merchant)
      item_1 = create(:item, merchant: @merch_one)
      @merch_two = create(:merchant)
      item_2 = create(:item, merchant: @merch_two)
      @merch_three = create(:merchant)
      item_3 = create(:item, merchant: @merch_three)
      invoice_1 = create(:invoice, customer: @customer, merchant: @merch_one)
      transaction_1 = create(:transaction, invoice: invoice_1, created_at: @date_1)
      invoice_2 = create(:invoice, customer: @customer, merchant: @merch_two)
      transaction_2 = create(:transaction, invoice: invoice_2, created_at: @date_1)
      invoice_3 = create(:invoice, customer: @customer, merchant: @merch_three)
      transaction_3 = create(:transaction, invoice: invoice_3, created_at: date_2)
      invoice_4 = create(:invoice, customer: @customer, merchant: @merch_three)
      transaction_4 = create(:transaction, invoice: invoice_4, created_at: date_2)
      invoice_item_1 = create(:invoice_item, item: item_1, invoice: invoice_1, quantity: 2)
      invoice_item_2 = create(:invoice_item, item: item_2, invoice: invoice_2)
      invoice_item_3 = create(:invoice_item, item: item_3, invoice: invoice_3, quantity: 2)
      invoice_item_4 = create(:invoice_item, item: item_3, invoice: invoice_4, unit_price: 4)
    end

    describe 'most_revenue' do
      it 'returns merchants with the highest revenue' do
        result = Merchant.most_revenue(2)

        expect(result).to eq([@merch_three, @merch_one])
      end
    end

    describe 'most_items' do
      it 'returns merchants with the most items sold' do
        result = Merchant.most_items(2)

        expect(result).to eq([@merch_three, @merch_one])
      end
    end

    describe 'favorite_customer' do
      it 'returns a customer who has made the most transactions with a merchant' do
        result = Merchant.favorite_customer(@merch_one.id)[0]

        expect(result).to eq(@customer)
      end
    end
  end

  describe 'instance methods' do
    before(:each) do
      @date_1 = "2012-03-27 14:56:04 UTC"
      date_2 = "2012-04-27 14:56:04 UTC"
      customer = create(:customer)
      @merch_one = create(:merchant)
      item_1 = create(:item, merchant: @merch_one)
      invoice_1 = create(:invoice, customer: customer, merchant: @merch_one)
      transaction_1 = create(:transaction, invoice: invoice_1, created_at: @date_1)
      invoice_2 = create(:invoice, customer: customer, merchant: @merch_one)
      transaction_2 = create(:transaction, invoice: invoice_2, created_at: @date_1, result: 0)
      invoice_item_1 = create(:invoice_item, item: item_1, invoice: invoice_1, quantity: 2)
      invoice_item_2 = create(:invoice_item, item: item_1, invoice: invoice_2)
    end
    describe 'total_revenue' do
      it 'returns the total revenue for that merchant' do
        result = @merch_one.total_revenue

        expect(result[0].revenue).to eq(22)
      end
    end
    describe 'total_revenue_for_date' do
      it 'returns the total revenue for that merchant by date' do
        result = @merch_one.total_revenue_for_date(@date_1)

        expect(result[0].revenue).to eq(26)
      end
    end
  end
end
