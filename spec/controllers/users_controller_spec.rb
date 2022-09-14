# frozen_string_literal: true

RSpec.describe UsersController, type: :controller do
  let!(:user) { create(:user) }

  before { controller.stub(:current_user) { user } }

  describe 'GET #edit' do
    before { get :edit, params: { id: user.id } }

    it 'render edit' do
      expect(response).to render_template(:edit)
    end
  end

  describe 'PUT #update' do
    context 'when good update' do
      let(:password) { 'Password1' }
      let(:password_confirmation) { password }

      before do
        put :update,
            params: { id: user.id,
                      user: { current_password: user.password, password: password,
                              password_confirmation: password_confirmation } }
      end

      it 'redirect_to root_path' do
        expect(response).to redirect_to(root_path)
      end
    end

    context 'when bad update' do
      let(:invalid_old_password) { '123' }
      let(:invalid_password) { '123' }
      let(:invalid_password_confirmation) { '123' }

      before do
        put :update,
            params: { id: user.id,
                      user: { current_password: invalid_old_password, password: invalid_password,
                              password_confirmation: invalid_password_confirmation } }
      end

      it 'render edit' do
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE #destroy' do
    before do
      delete :destroy,
             params: { id: user.id }
    end

    it 'redirect_to root_path' do
      expect(response).to redirect_to(root_path)
    end
  end
end
