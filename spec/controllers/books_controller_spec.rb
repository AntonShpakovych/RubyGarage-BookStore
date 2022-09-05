# frozen_string_literal: true

RSpec.describe BooksController, type: :controller do
  describe 'GET #index' do
    context "when params doesn't have index and category" do
      before { get :index, params: {} }

      it 'renders index template' do
        expect(response).to render_template(:index)
      end
    end

    BookQuery::FILTER_KEYS.each do |key, _value|
      before { get :index, params: { filter: key } }

      context "when params have #{key}" do
        it 'render index template' do
          expect(response).to render_template(:index)
        end
      end
    end
  end

  describe 'GET #show' do
    let(:book) { create(:book) }

    before { get :show, params: { id: book.id } }

    it 'render show template' do
      expect(response).to render_template(:show)
    end
  end
end
