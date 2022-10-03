# frozen_string_literal: true

RSpec.describe ReviewsController, type: :controller do
  let!(:user) { create(:user) }
  let!(:book) { create(:book) }

  before { controller.stub(:current_user) { user } }

  describe 'POST #create' do
    context 'when good create' do
      let(:params) do
        { book_id: book.id,
          review: { title: attributes_for(:review)[:title],
                    text: attributes_for(:review)[:text],
                    rating: attributes_for(:review)[:rating],
                    user_id: user.id,
                    book_id: book.id } }
      end

      before { post :create, params: params }

      it 'redirect_to book_path' do
        expect(response).to redirect_to(book_path(book.id))
      end
    end

    context 'when bad create' do
      let(:params) do
        { book_id: book.id,
          review: { title: '', text: '', rating: '', user_id: user.id, book_id: book.id } }
      end

      before { post :create, params: params }

      it 'redirect_to book_path' do
        expect(response).to redirect_to(book_path(book.id))
      end
    end
  end
end
