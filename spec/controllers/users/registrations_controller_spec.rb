# frozen_string_literal: true

RSpec.describe Users::RegistrationsController do
  before { request.env['devise.mapping'] = Devise.mappings[:user] }

  describe 'POST #create' do
    let(:params) { { user: { email: email, quick: true } } }

    context 'when quick registration' do
      before { post :create, params: params }

      context 'when params good' do
        let(:email) { attributes_for(:user)[:email] }

        it 'redirect_to Checkout/address also show message about password instructions' do
          expect(response).to redirect_to(checkout_path)
          expect(flash[:notice]).to eq(t('devise.quick_registration.message.password_instructions'))
        end
      end

      context 'when params bad' do
        let(:user) { create(:user) }
        let(:email) { user.email }

        it 'redirect_to cart, and show error about existing email' do
          expect(response).to redirect_to(cart_path)
          expect(flash[:alert]).to eq(t('devise.default.email_not_uniq'))
        end
      end
    end
  end
end
