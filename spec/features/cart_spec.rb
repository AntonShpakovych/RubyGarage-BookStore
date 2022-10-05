# frozen_string_literal: true

RSpec.describe 'Cart page', type: :feature do
  let(:result) { page }

  context 'when cart not empty' do
    let!(:book) { create(:book) }
    let(:create_order_item) { create(:order_item, order: find_order, book: book) }
    let(:expect_result_for_quantity) { create_order_item.quantity }
    let(:expect_result_for_subtotal_price) { create_order_item.decorate.subtotal_price }
    let(:find_order) { Order.find_by(status: :unprocessed) }
    let(:decorate_order) { find_order.decorate }
    let(:expect_result_for_discount) { decorate_order.discount }
    let(:expect_result_for_order_total) { decorate_order.order_total }

    before do
      visit root_path
      create_order_item
      visit cart_path
    end

    context 'when user on page cart he can see' do
      it 'user can see quantity of order_item' do
        expect(result).to have_text(expect_result_for_quantity)
      end

      it 'we can see subtotal_price for order_item' do
        expect(result).to have_text(expect_result_for_subtotal_price)
      end

      it 'user can see discount if present of 0' do
        expect(result).to have_text(expect_result_for_discount)
      end

      it 'user can see order_total' do
        expect(result).to have_text(expect_result_for_order_total)
      end
    end

    context 'when user want delete order_item' do
      let(:expected_result) { find_order.order_items }
      let(:result_delete) { result.find('a', class: 'close general-cart-close', match: :first) }

      it 'delete order_item' do
        expect { result_delete.click }.to change(expected_result, :count)
      end
    end
  end

  context 'when cart is empty' do
    let(:expected_result_for_message) { t('carts.partials.cart_without_order.message_empty') }
    let(:expected_result_for_link) { t('carts.partials.cart_without_order.link_add_to_cart') }

    before { visit cart_path }

    it 'render empty page with message notification' do
      expect(result).to have_text(expected_result_for_message)
    end

    it 'on page have link to catalog' do
      expect(result).to have_link(expected_result_for_link)
    end
  end
end
