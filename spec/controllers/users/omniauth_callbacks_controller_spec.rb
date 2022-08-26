RSpec.describe Users::OmniauthCallbacksController do
  describe '#google_oauth2' do
      before do
        OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new(Faker::Omniauth.google)
        request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:google_oauth2]
        request.env['devise.mapping'] = Devise.mappings[:user]
        get :google_oauth2
      end

      it 'set current user' do
        expect(subject.current_user).not_to be_nil
      end

      it { should set_flash }

      it { should redirect_to(root_path) }
  end
end
