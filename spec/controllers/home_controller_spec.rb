# frozen_string_literal: true

RSpec.describe HomeController, type: :request do
  describe 'GET root_path' do
    before { get root_path }

    it 'renders index template' do
      expect(response).to render_template(:index)
    end
  end
end
