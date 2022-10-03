# frozen_string_literal: true

RSpec.describe ReviewForm, type: :model do
  let!(:current_user) { create(:user) }
  let!(:book) { create(:book) }

  let(:initialize_review) { Review.new(params) }
  let(:create_form) { described_class.new(initialize_review, params) }

  let(:params) do
    { title: title,
      text: text,
      rating: rating,
      user_id: current_user.id,
      book_id: book.id }
  end

  let(:title) { attributes_for(:review)[:title] }
  let(:text) { attributes_for(:review)[:text] }
  let(:rating) { attributes_for(:review)[:rating] }

  context 'when valid review' do
    let(:result_for_create_new_review) { create_form.save }

    it 'create new review' do
      expect(result_for_create_new_review).to be_kind_of(Review)
    end

    it 'stores params attributes in similar model attributes' do
      params.each do |key, value|
        expect(result_for_create_new_review[key]).to eq(value)
      end
    end
  end

  context 'when invalid review' do
    let(:result_error) { create_form.errors }

    before { create_form.save }

    context 'when bad rating' do
      let(:rating) { 7 }

      it 'add errors rating' do
        expect(result_error).to be_key(:rating)
      end
    end

    context 'when bad title' do
      let(:title) { 'T' * described_class::MAX_LENGTH_TITLE.next }

      it 'add errors title' do
        expect(result_error).to be_key(:title)
      end
    end

    context 'when bad text' do
      let(:text) { 'T' * described_class::MAX_LENGTH_TEXT.next }

      it 'add errors text' do
        expect(result_error).to be_key(:text)
      end
    end
  end
end
