# frozen_string_literal: true

RSpec.describe 'Book page', type: :feature do
  describe 'Back to results' do
    let(:book) { create(:book) }
    let(:book_page_path) { "/books/#{book.id}" }

    before do
      book
      visit books_path
    end

    it 'back to previously url' do
      find_link(:href => "/books/#{book.id}").click
      expect(page).to have_current_path(book_page_path, ignore_query: true)
      find_link(t('books.show.back_to_result')).click
      expect(page).to have_current_path(books_path, ignore_query: true)
    end
  end

  describe 'Read more button' do
    context "when book.description.length > #{BookDecorator::SHORT_DESCRIPTION_LENGTH}" do
      let(:book) { create(:book) }

      before do
        book
        visit book_path(book.id)
      end

      it 'page has button Read more and display div with short description' do
        expect(page).to have_selector('div', id: 'book_description_short')
        expect(page).to have_selector('div', id: 'book_description_all', class: 'hide_description')
        expect(page).to have_button(t('books.show.read_more'))
      end

      context 'when user click on button' do
        it 'present full description' do
          click_button(t('books.show.read_more'))
          expect(page).to have_selector('div', id: 'book_description_all')
        end
      end
    end
  end
end
