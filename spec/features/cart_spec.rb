# frozen_string_literal: true

RSpec.describe 'Cart page', type: :feature do
  let(:result) { page }

  context 'when cart not empty' do
    let(:checkout_link) { result.find('a', class: 'btn btn-default mb-20') }

    context 'when user not authorizate' do
      let!(:book) { create(:book) }
      let(:create_order_item) { create(:order_item, order: find_order, book: book) }
      let(:expect_result_for_quantity) { create_order_item.quantity }
      let(:expect_result_for_subtotal_price) { create_order_item.decorate.subtotal_price }
      let(:find_order) { Order.find_by(status: :unprocessed) }
      let(:decorate_order) { find_order.decorate }
      let(:expect_result_for_discount) { decorate_order.discount }
      let(:expect_result_for_total_price) { decorate_order.total_price }

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
          expect(result).to have_text(expect_result_for_total_price)
        end
      end

      context 'when user want delete order_item' do
        let(:expected_result) { find_order.order_items }
        let(:result_delete) { result.find('a', class: 'close general-cart-close', match: :first) }

        it 'delete order_item' do
          expect { result_delete.click }.to change(expected_result, :count)
        end
      end

      context 'when user want update quantity order_item but book.quantity less' do
        let!(:book) { create(:book, quantity: 0) }
        let(:create_order_item) { create(:order_item, order_id: find_order.id, book: book) }
        let(:find_order) { Order.find_by(status: :unprocessed) }
        let(:find_button) { result.all('a', class: 'input-link').last }

        before { find_button.click }

        it 'show message book dont have quantity wich u want' do
          expect(result).to have_text(t('carts.message.book_quantity_less'))
        end
      end

      context 'when user click on Checkout' do
        before { checkout_link.click }

        it 'render page Checkout/need_authorization' do
          expect(result.current_path).to eq(checkout_path)
        end
      end
    end

    context 'when user already authorizate' do
      context 'when user click Checkout' do
        let!(:user) { create(:user) }
        let!(:order_item) { create(:order_item) }
        let(:order) { create(:order, order_items: [order_item], user: user) }

        before do
          order
          visit new_user_session_path
          fill_in t('devise.placeholder.email'), with: user.email
          fill_in t('devise.placeholder.password'), with: user.password
          click_button t('devise.default.log_in')
          visit cart_path
          checkout_link.click
        end

        it 'render page Checkout/address' do
          expect(result.current_path).to eq(checkout_path)
          expect(result).to have_text(t('checkouts.partials.address.title'))
        end
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
