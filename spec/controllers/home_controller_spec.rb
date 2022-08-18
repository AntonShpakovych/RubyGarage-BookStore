# frozen_string_literal: true

RSpec.describe HomeController, type: :controller do
  describe 'GET root_path' do
    before { get :index }

    it 'renders index template' do
      expect(response).to render_template(:index)
    end
  end
end
