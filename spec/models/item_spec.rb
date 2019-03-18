require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'relationships' do
    it { should belong_to :merchant}
    it { should have_many :invoice_items }
    it { should have_many :invoices }
  end

  describe 'class methods' do
    before(:each) do
      @date_1 = "2012-03-27 14:56:04 UTC"
      @date_2 = "2012-04-27 14:56:04 UTC"
      @customer = create(:customer)
      @merch_one = create(:merchant)
      @item_1 = create(:item, merchant: @merch_one)
      @merch_two = create(:merchant)
      @item_2 = create(:item, merchant: @merch_two)
      @merch_three = create(:merchant)
      @item_3 = create(:item, merchant: @merch_three)
      invoice_1 = create(:invoice, customer: @customer, merchant: @merch_one, created_at: @date_1)
      transaction_1 = create(:transaction, invoice: invoice_1, created_at: @date_1)
      invoice_2 = create(:invoice, customer: @customer, merchant: @merch_two, created_at: @date_1)
      transaction_2 = create(:transaction, invoice: invoice_2, created_at: @date_1)
      invoice_3 = create(:invoice, customer: @customer, merchant: @merch_three, created_at: @date_1)
      transaction_3 = create(:transaction, invoice: invoice_3, created_at: @date_2)
      invoice_4 = create(:invoice, customer: @customer, merchant: @merch_three, created_at: @date_2)
      transaction_4 = create(:transaction, invoice: invoice_4, created_at: @date_2)
      invoice_5 = create(:invoice, customer: @customer, merchant: @merch_three, created_at: @date_1)
      transaction_5 = create(:transaction, invoice: invoice_4, created_at: @date_2, result: 0)
      invoice_item_1 = create(:invoice_item, item: @item_1, invoice: invoice_1, quantity: 2)
      invoice_item_2 = create(:invoice_item, item: @item_2, invoice: invoice_2)
      invoice_item_3 = create(:invoice_item, item: @item_3, invoice: invoice_3, quantity: 2)
      invoice_item_4 = create(:invoice_item, item: @item_3, invoice: invoice_4, unit_price: 4)
    end
    describe 'most_revenue' do
      it 'returns the items ranked by total rev generated' do

        expect(Item.most_revenue(2)).to eq([@item_3, @item_1])
      end
    end

    describe 'most_items_sold' do
      it 'returns the items ranked by quantity sold for items' do

        expect(Item.most_items_sold(2)).to eq([@item_3, @item_1])
      end
    end

    describe 'best_day' do
      it 'returns the date that the item was sold the most of on' do

        result = Item.best_day(@item_3)[0]

        expect(result.best_day.to_s).to eq(@date_1)
      end
    end
  end
end
