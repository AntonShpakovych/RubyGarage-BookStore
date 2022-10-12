# frozen_string_literal: true

RSpec.describe CheckoutConfirmService do
  let!(:order) { create(:order, :order_items, :credit_card, :delivery) }
  let!(:user) { create(:user, orders: [order]) }
  let(:billing_address) { create(:address, :billing_address, user: user) }
  let(:shipping_address) { create(:address, :shipping_address, user: user) }
  let(:checkouts_confrim_service) { described_class.new(user, order, params) }
  let(:result) { order.state }
  let(:set_confirme) do
    order.to_delivery!
    order.to_payment!
    order.to_confirm!
  end

  before do
    billing_address
    shipping_address
    set_confirme
    checkouts_confrim_service.call
  end

  context 'when user want complete order' do
    let(:result_status) { order.status }
    let(:result_number) { order.number }
    let(:expected_result_state) { 'complete' }
    let(:expected_result_status) { 'in_queue' }
    let(:params) { { confirm: true } }

    it 'change order.sate to complete' do
      expect(result).to eq(expected_result_state)
    end

    it 'change status to in_queue' do
      expect(result_status).to eq(expected_result_status)
    end

    it 'generate number for order' do
      expect(result_number).to be_present
    end
  end

  context 'when rollback' do
    context 'when user want roll back to address' do
      let(:expected_result) { 'address' }
      let(:params) { { state: 'address' } }

      it 'roll back to address' do
        expect(order.state).to eq(expected_result)
      end
    end

    context 'when user want roll back to delivery' do
      let(:expected_result) { 'delivery' }
      let(:params) { { state: 'delivery' } }

      it 'roll back to address' do
        expect(order.state).to eq(expected_result)
      end
    end

    context 'when user want roll back to payment' do
      let(:expected_result) { 'payment' }
      let(:params) { { state: 'payment' } }

      it 'roll back to address' do
        expect(order.state).to eq(expected_result)
      end
    end
  end
end
