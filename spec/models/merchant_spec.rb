require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'relationships' do
    it { should have_many :items }
  end

  describe 'class methods' do
    before(:each) do
      customer = create(:customer)
      @merch_one = create(:merchant)
      item_1 = create(:item, merchant: @merch_one)
      @merch_two = create(:merchant)
      item_2 = create(:item, merchant: @merch_two)
      @merch_three = create(:merchant)
      item_3 = create(:item, merchant: @merch_three)
      invoice_1 = create(:invoice, customer: customer, merchant: @merch_one)
      transaction_1 = create(:transaction, invoice: invoice_1)
      invoice_2 = create(:invoice, customer: customer, merchant: @merch_two)
      transaction_2 = create(:transaction, invoice: invoice_2)
      invoice_3 = create(:invoice, customer: customer, merchant: @merch_three)
      transaction_3 = create(:transaction, invoice: invoice_3)
      invoice_4 = create(:invoice, customer: customer, merchant: @merch_three)
      transaction_4 = create(:transaction, invoice: invoice_4)
      invoice_item_1 = create(:invoice_item, item: item_1, invoice: invoice_1, quantity: 2)
      invoice_item_2 = create(:invoice_item, item: item_2, invoice: invoice_2)
      invoice_item_3 = create(:invoice_item, item: item_3, invoice: invoice_3)
      invoice_item_4 = create(:invoice_item, item: item_3, invoice: invoice_4, unit_price: 4)
    end

    describe 'most_revenue' do
      it 'returns merchants with the highest revenue' do
        result = Merchant.most_revenue(2)

        expect(result).to eq([@merch_three, @merch_one])
      end
    end
  end
end
