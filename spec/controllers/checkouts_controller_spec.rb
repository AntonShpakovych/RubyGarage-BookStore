# frozen_string_literal: true

RSpec.describe CheckoutsController, type: :controller do
  describe 'Address' do
    describe 'GET #show' do
      before { get :show }

      it 'render show' do
        expect(response).to render_template(:show)
      end
    end

    describe 'PUT #update' do
      let(:params) do
        { address: { billing: {
                       first_name: attributes_for(:address)[:first_name],
                       last_name: attributes_for(:address)[:last_name],
                       address: attributes_for(:address)[:address],
                       city: attributes_for(:address)[:city],
                       zip: attributes_for(:address)[:zip],
                       country: attributes_for(:address)[:country],
                       phone: attributes_for(:address)[:phone]
                     },
                     shipping: {
                       first_name: attributes_for(:address)[:first_name],
                       last_name: attributes_for(:address)[:last_name],
                       address: attributes_for(:address)[:address],
                       city: attributes_for(:address)[:city],
                       zip: attributes_for(:address)[:zip],
                       country: attributes_for(:address)[:country],
                       phone: attributes_for(:address)[:phone]
                     } } }
      end

      before { put :update, params: params }

      it 'render show' do
        expect(response).to render_template(:show)
      end
    end
  end

  describe 'Delivery' do
    describe 'GET #show' do
      before { get :show }

      it 'render show' do
        expect(response).to render_template(:show)
      end
    end

    describe 'PUT #update' do
      let!(:user) { create(:user) }
      let(:order) { create(:order, user: user) }
      let(:set_delivery) { order.to_delivery! }
      let!(:delivery) { create(:delivery) }
      let(:params) { { delivery_id: delivery.id } }

      before do
        controller.stub(:current_user) { user }
        set_delivery
        put :update, params: params
      end

      it 'render show' do
        expect(response).to render_template(:show)
      end
    end
  end

  describe 'Payment' do
    describe 'GET #show' do
      before { get :show }

      it 'render show' do
        expect(response).to render_template(:show)
      end
    end

    describe 'PUT #update' do
      let!(:user) { create(:user) }
      let!(:order) { create(:order, user: user) }
      let(:set_paymant) do
        order.to_delivery!
        order.to_payment!
      end
      let!(:number) { attributes_for(:credit_card)[:number] }
      let!(:name) { attributes_for(:credit_card)[:name] }
      let!(:cvv) { attributes_for(:credit_card)[:cvv] }
      let!(:date) { attributes_for(:credit_card)[:date] }
      let(:params) { { payment: { number: number, name: name, cvv: cvv, date: date } } }

      before do
        controller.stub(:current_user) { user }
        set_paymant
        put :update, params: params
      end

      it 'render show' do
        expect(response).to render_template(:show)
      end
    end
  end
end
