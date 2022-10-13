# frozen_string_literal: true

RSpec.describe 'Orders page', type: :feature do
  let(:billing_address) { create(:address, :billing_address, user: user) }
  let(:shipping_address) { create(:address, :shipping_address, user: user) }
  let(:delivery) { create(:delivery, orders: [order1]) }
  let(:credit_card) { create(:credit_card, order: order1) }
  let(:result) { page }
  let!(:order1) { create(:order, :order_items) }
  let!(:user) { create(:user, orders: [order1]) }
  let(:expected_result) { order1.number }

  before do
    visit new_user_session_path
    fill_in t('devise.placeholder.email'), with: user.email
    fill_in t('devise.placeholder.password'), with: user.password
    click_button t('devise.default.log_in')
    billing_address
    shipping_address
    delivery
    credit_card
    visit orders_path
  end

  describe '#index' do
    context 'when user sort order by status' do
      let(:link) { result.find("a[href='/orders?status=in_queue']") }

      context 'when user have orders with choosed status' do
        before do
          order1.in_queue!
          link.click
        end

        it 'display all orders where status in_queue' do
          expect(result).to have_text(expected_result)
        end
      end

      context 'when user not have orders with choosed status' do
        before { link.click }

        it 'not show orders where status != choosed status' do
          expect(result).not_to have_text(expected_result)
        end
      end
    end
  end

  describe '#show' do
    let(:expected_result_billing) { billing_address.first_name }
    let(:expected_result_shipping) { shipping_address.first_name }
    let(:expected_result_delivery) { delivery.name }
    let(:expected_result_book) { order1.order_items.sample.book.name }

    before do
      order1.in_queue!
      visit orders_path
      result.find("a[href='/orders/#{order1.id}']", match: :first).click
    end

    it 'render page show with more info about order' do
      expect(result).to have_text(expected_result)
    end

    it 'have info about billing_address' do
      expect(result).to have_text(expected_result_billing)
    end

    it 'have info about shipping_address' do
      expect(result).to have_text(expected_result_shipping)
    end

    it 'have info about delivery' do
      expect(result).to have_text(expected_result_delivery)
    end

    it 'have info about book in order' do
      expect(result).to have_text(expected_result_book)
    end
  end
end
