# frozen_string_literal: true

RSpec.describe 'Book page', type: :feature do
  describe 'Back to results' do
    let!(:book) { create(:book) }
    let(:book_page_path) { "/books/#{book.id}" }

    let(:result) { page }
    let(:expected_result) { books_path }

    before do
      visit books_path
      find_link(:href => book_page_path).click
      find_link(t('books.show.back_to_result')).click
    end

    it 'back_to previously_url' do
      expect(result).to have_current_path(expected_result, ignore_query: true)
    end
  end

  describe 'Read more button' do
    context "when book.description.length > #{BookDecorator::SHORT_DESCRIPTION_LENGTH}" do
      let!(:book) { create(:book) }
      let(:result) { page }

      let(:expected_result_tag) { 'div' }

      let(:expected_result_id1) { 'book_description_short' }
      let(:expected_result_id2) { 'book_description_all' }

      let(:expected_result_class) { 'hide_description' }

      let(:expected_result3) { t('books.show.read_more') }

      before do
        visit book_path(book.id)
      end

      it 'page has button Read more and display div with short description' do
        expect(result).to have_selector(expected_result_tag, id: expected_result_id1)
        expect(result).to have_selector(expected_result_tag, id: expected_result_id2, class: expected_result_class)
        expect(result).to have_button(expected_result3)
      end

      context 'when user click on button' do
        before { click_button(t('books.show.read_more')) }

        it 'present full description' do
          expect(result).to have_selector(expected_result_tag, id: expected_result_id2)
        end
      end
    end
  end
end
