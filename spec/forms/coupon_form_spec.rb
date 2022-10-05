# frozen_string_literal: true

RSpec.describe CouponForm, type: :model do
  let!(:current_order) { create(:order) }
  let(:params) { { code: code, order_id: current_order.id } }
  let(:coupon_form) { described_class.new(coupon, params) }
  let(:coupon_create) { coupon }

  before { coupon_form.save }

  context 'when coupon not have order_id' do
    let(:coupon) { create(:coupon) }
    let(:code) { coupon.code }
    let(:result_for_coupon) { Coupon.find_by(order_id: expect_result_for_coupon).order_id }
    let(:expect_result_for_coupon) { current_order.id }

    it 'Add to coupon order_id' do
      expect(result_for_coupon).to eq(expect_result_for_coupon)
    end
  end

  context 'when coupon already have order_id' do
    let!(:coupon) { create(:coupon, order: current_order) }
    let(:code) { coupon.code }
    let(:result) { coupon_form.errors.key?(:order_id) }

    it 'Add to coupon order_id' do
      expect(result).to be_truthy
    end
  end
end
