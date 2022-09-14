# frozen_string_literal: true

RSpec.describe AddressesController, type: :controller do
  let!(:user) { create(:user) }
  let(:first_name_valid) { 'First' }
  let(:first_name_invalid) { 'First1' }
  let(:last_name) { 'Last' }
  let(:address) { 'Address 2' }
  let(:city) { 'Citynew' }
  let(:country) { 'UA' }
  let(:phone) { '+380982020202' }
  let(:zip) { '33027' }
  let(:type) { BillingAddress.name }

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
      before do
        put :update, params: { id: user.id,
                               address: { first_name: first_name_valid,
                                          last_name: last_name,
                                          address: address,
                                          city: city,
                                          country: country,
                                          phone: phone,
                                          zip: zip,
                                          type: type } }
      end

      it 'redirect_to root_path' do
        expect(response).to redirect_to(root_path)
      end
    end

    context 'when bad update' do
      before do
        put :update, params: { id: user.id,
                               address: { first_name: first_name_invalid,
                                          last_name: last_name,
                                          address: address,
                                          city: city,
                                          country: country,
                                          phone: phone,
                                          zip: zip,
                                          type: type } }
      end

      it 'render edit' do
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'POST #create' do
    context 'when good create' do
      before do
        post :create, params: { id: user.id,
                                address: { first_name: first_name_valid,
                                           last_name: last_name,
                                           address: address,
                                           city: city,
                                           country: country,
                                           phone: phone,
                                           zip: zip,
                                           type: type } }
      end

      it 'redirect_to root_path' do
        expect(response).to redirect_to(root_path)
      end
    end

    context 'when bad create' do
      before do
        post :create, params: { id: user.id,
                                address: { first_name: first_name_invalid,
                                           last_name: last_name,
                                           address: address,
                                           city: city,
                                           country: country,
                                           phone: phone,
                                           zip: zip,
                                           type: type } }
      end

      it 'render edit page' do
        expect(response).to render_template(:edit)
      end
    end
  end
end
