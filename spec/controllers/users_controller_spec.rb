# frozen_string_literal: true

RSpec.describe UsersController, type: :controller do
  let!(:user) { create(:user) }
  let(:params) { { id: user.id } }

  before { controller.stub(:current_user) { user } }

  describe 'GET #edit' do
    before { get :edit, params: params }

    it 'render edit' do
      expect(response).to render_template(:edit)
    end
  end

  describe 'DELETE #destroy' do
    before do
      delete :destroy,
             params: params
    end

    it 'redirect_to root_path' do
      expect(response).to redirect_to(root_path)
    end
  end
end
