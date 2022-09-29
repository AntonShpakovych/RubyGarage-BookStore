# frozen_string_literal: true

RSpec.describe UpdatePasswordsController, type: :controller do
  let!(:user) { create(:user) }

  before { controller.stub(:current_user) { user } }

  describe 'PUT #update' do
    context 'when good update password' do
      let(:new_password_good) { FFaker::Internet.password(9, 16) + rand(1..9).to_s }
      let(:old_password) { user.password }
      let(:password_confirmation) { new_password_good }

      let(:params) do
        { user: { current_password: old_password, password: new_password_good,
                  password_confirmation: password_confirmation } }
      end

      before { put :update, params: params }

      it 'redirect_to root_path' do
        expect(response).to redirect_to(root_path)
      end
    end

    context 'when bad update password' do
      let(:params) do
        { user: { current_password: 'not current_password' } }
      end

      before { put :update, params: params }

      it 'render user_path' do
        expect(response).to render_template('users/edit')
      end
    end
  end
end
