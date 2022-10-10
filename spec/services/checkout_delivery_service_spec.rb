# frozen_string_literal: true

RSpec.describe CheckoutDeliveryService do
  let(:billing_address) { create(:address, :billing_address, user: user) }
  let(:shipping_address) { create(:address, :shipping_address, user: user) }
  let!(:user) { create(:user) }
  let!(:order) { create(:order, user: user) }
  let(:params) { { delivery_id: delivery.id } }
  let(:delivery) { create(:delivery) }
  let(:delivery_service) { described_class.new(user, order, params) }

  let(:result) { order.delivery }
  let(:expected_result) { delivery }
  let(:result_state) { order.state }
  let(:expected_result_state) { 'payment' }

  before do
    billing_address
    shipping_address
    order.to_delivery!
    delivery_service.call
  end

  it 'from params add delivery to order' do
    expect(result).to eq(expected_result)
  end

  it 'change order.state' do
    expect(result_state).to eq(expected_result_state)
  end
end
