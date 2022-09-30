# frozen_string_literal: true

RSpec.describe AddressesController, type: :controller do
  let!(:user) { create(:user) }
  let(:first_name_valid) { attributes_for(:address)[:first_name] }
  let(:first_name_invalid) { 'First1' }
  let(:last_name) { attributes_for(:address)[:last_name] }
  let(:address) { attributes_for(:address)[:address] }
  let(:city) { attributes_for(:address)[:city] }
  let(:country) { attributes_for(:address)[:country] }
  let(:phone) { attributes_for(:address)[:phone] }
  let(:zip) { attributes_for(:address)[:zip] }
  let(:type) { BillingAddress.name }

  let(:params_good) do
    { address: { first_name: first_name_valid,
                 last_name: last_name,
                 address: address,
                 city: city,
                 country: country,
                 phone: phone,
                 zip: zip,
                 type: type } }
  end

  let(:params_bad) do
    { address: { first_name: first_name_invalid,
                 last_name: last_name,
                 address: address,
                 city: city,
                 country: country,
                 phone: phone,
                 zip: zip,
                 type: type } }
  end

  before { controller.stub(:current_user) { user } }

  describe 'GET #edit' do
    before do
      get :edit, params: { id: user.id }
    end

    it 'render edit' do
      expect(response).to render_template(:edit)
    end
  end

  describe 'PUT #update' do
    let!(:address_class) { create(:address, :billing_address) }
    let(:user) { address_class.user }

    context 'when good update' do
      before { put :update, params: params_good }

      it 'redirect_to edit_address' do
        expect(response).to redirect_to(edit_address_path)
      end
    end

    context 'when bad update' do
      before { put :update, params: params_bad }

      it 'render edit' do
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'POST #create' do
    context 'when good create' do
      before { post :create, params: params_good }

      it 'redirect_to edit_address' do
        expect(response).to redirect_to(edit_address_path)
      end
    end

    context 'when bad create' do
      before { post :create, params: params_bad }

      it 'render edit page' do
        expect(response).to render_template(:edit)
      end
    end
  end
end
