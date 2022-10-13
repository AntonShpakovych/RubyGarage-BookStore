# frozen_string_literal: true

RSpec.describe BookBestSellersService do
  let(:max_quantity) { 8 }
  let(:book_best_sellers_service) { described_class }
  let(:result) { book_best_sellers_service.call }
  let(:expected_result) { [book8, book6, book4, book2] }
  let!(:category1) { create(:category, name: 'Category1') }
  let!(:category2) { create(:category, name: 'Category2') }
  let!(:category3) { create(:category, name: 'Category3') }
  let!(:category4) { create(:category, name: 'Category4') }

  let!(:book1) { create(:book, category: category1, quantity: max_quantity) }
  let!(:book2) { create(:book, category: category1, quantity: max_quantity) }
  let!(:book3) { create(:book, category: category2, quantity: max_quantity) }
  let!(:book4) { create(:book, category: category2, quantity: max_quantity) }
  let!(:book5) { create(:book, category: category3, quantity: max_quantity) }
  let!(:book6) { create(:book, category: category3, quantity: max_quantity) }
  let!(:book7) { create(:book, category: category4, quantity: max_quantity) }
  let!(:book8) { create(:book, category: category4, quantity: max_quantity) }

  let!(:order_item1) { create(:order_item, book: book1, quantity: 1) }
  let!(:order_item2) { create(:order_item, book: book2, quantity: 2) }
  let!(:order_item3) { create(:order_item, book: book3, quantity: 3) }
  let!(:order_item4) { create(:order_item, book: book4, quantity: 4) }
  let!(:order_item5) { create(:order_item, book: book5, quantity: 5) }
  let!(:order_item6) { create(:order_item, book: book6, quantity: 6) }
  let!(:order_item7) { create(:order_item, book: book7, quantity: 7) }
  let!(:order_item8) { create(:order_item, book: book8, quantity: 8) }

  let(:order1) { create(:order, order_items: [order_item1, order_item2]) }
  let(:order2) { create(:order, order_items: [order_item3, order_item4]) }
  let(:order3) { create(:order, order_items: [order_item5, order_item6]) }
  let(:order4) { create(:order, order_items: [order_item7, order_item8]) }

  before do
    order1.in_queue!
    order2.in_queue!
    order3.in_queue!
    order4.in_queue!
  end

  it 'give the best-selling book in correct orders for each category' do
    expect(result).to eq(expected_result)
  end
end
