# frozen_string_literal: true

RSpec.describe UpdateEmailsController, type: :controller do
  let!(:user) { create(:user) }

  before { controller.stub(:current_user) { user } }

  describe 'PUT #update' do
    context 'when good update email' do
      let(:good_email) { FFaker::Internet.email }
      let(:params) { { email: { email: good_email } } }

      before { put :update, params: params }

      it 'redirect_to user_path' do
        expect(response).to redirect_to(user_path)
      end
    end

    context 'when bad update email' do
      let(:bad_email) { '--email@gmail.com' }
      let(:params) { { email: { email: bad_email } } }

      before { put :update, params: params }

      it 'render users edit' do
        expect(response).to render_template('users/edit')
      end
    end
  end
end
