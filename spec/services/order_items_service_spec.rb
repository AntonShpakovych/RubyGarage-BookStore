# frozen_string_literal: true

RSpec.describe OrderItemsService do
  let(:order) { order }
  let(:order_items_service) { described_class.new(order: order, params: params) }
  let(:params) { { book_id: book_id, quantity: quantity } }

  before { order_items_service.call }

  context 'when order not have order_items' do
    let!(:book) { create(:book) }
    let(:quantity) { described_class::DEFAULT_QUANTITY_INCREMENT }
    let(:order) { create(:order) }
    let(:book_id) { book.id }

    let(:result_order_items) { order.order_items.find_by(book_id: params[:book_id]) }
    let(:result_order_items_quantity) { result_order_items.quantity }
    let(:expected_result_for_quantity) { params[:quantity] }

    it 'create order_items for order with book from params[:book_id]' do
      expect(result_order_items).to be_truthy
    end

    it 'also add quantity from params[:quantity]' do
      expect(result_order_items_quantity).to eq(expected_result_for_quantity)
    end
  end

  context 'when order already have order_items' do
    let(:quantity) { described_class::DEFAULT_QUANTITY_INCREMENT }
    let(:book) { create(:book) }
    let(:order_item) { create(:order_item, book: book) }
    let(:book_id) { order_item.book_id }
    let(:order) { create(:order, order_items: [order_item]) }

    let(:result_order_items_quantity) { OrderItem.find_by(id: order_item.id).quantity }
    let(:expected_result_for_quantity) { params[:quantity] + order_item.quantity }

    context 'when order_item.quantity + params[:quantity] < order_item.book.quantity' do
      it 'can increase order_items.quantity' do
        expect(result_order_items_quantity).to eq(expected_result_for_quantity)
      end
    end

    context 'when order_item.quantity + params[:quantity] > order_item.book.quantity' do
      let(:book) { create(:book, quantity: quantity) }
      let(:order_item) { create(:order_item, book: book) }

      it 'not change order_item.quantity' do
        expect(result_order_items_quantity).to eq(quantity)
      end
    end

    context 'when deacrease' do
      context 'when order_item.quantity < 1' do
        let(:quantity) { -described_class::DEFAULT_QUANTITY_INCREMENT }
        let(:order_item) { create(:order_item, quantity: 2) }

        it 'decrease order_items.quantity by 1' do
          expect(result_order_items_quantity).to eq(expected_result_for_quantity)
        end
      end

      context 'when order_item.quantity == 1' do
        let(:quantity) { -described_class::DEFAULT_QUANTITY_INCREMENT }
        let(:result) { OrderItem.find_by(id: order_item.id) }

        it 'delete order_items' do
          expect(result).to be_nil
        end
      end
    end
  end
end
