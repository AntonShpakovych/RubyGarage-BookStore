# frozen_string_literal: true

RSpec.describe OrderItemDecorator do
  let(:order_item) { create(:order_item).decorate }

  describe '#subtotal_price' do
    let(:result) { order_item.subtotal_price }
    let(:expected_result) { order_item.quantity * order_item.book.price }

    it 'give how much money you need to pay for one order_item' do
      expect(result).to eq(expected_result)
    end
  end
end
