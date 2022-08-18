# frozen_string_literal: true

RSpec.describe 'Catalog page', type: :feature do
  describe 'Filtering and sorting' do
    context 'when user choose category' do
      let(:category1) { create(:category) }
      let(:category2) { create(:category) }
      let(:book1) { create(:book, category: category1) }
      let(:book2) { create(:book, category: category2) }

      before do
        book1
        book2
        visit books_path
        find('.filter-link', text: book1.category.name, match: :first).click
      end

      it 'shows books only from choosen category' do
        expect(page).to have_content(book1.name)
        expect(page).not_to have_content(book2.name)
      end
    end

    context 'when user choose filter' do
      let(:name_first) { 'AAAA' }
      let(:name_last) { 'BBBB' }
      let(:book1) { create(:book, name: name_first) }
      let(:book2) { create(:book, name: name_last) }

      before do
        book1
        book2
        visit books_path
        find('.dropdown-toggle.lead.small', text: t('books.partials.desktop.filter.name_asc'), match: :first).click
      end

      it "sorting books by #{BookQueries::FILTER_KEYS.keys.first}" do
        expect(page.find('.col-xs-6.col-sm-3', match: :first).text).to match(/#{book1.name}/)
      end
    end
  end

  describe 'Pagination' do
    describe "books length less #{Pagy::DEFAULT[:items]}" do
      let(:books_count) { 5 }

      before do
        books_count.times { create(:book) }
        visit books_path
      end

      context "when books length less then #{Pagy::DEFAULT[:items]}" do
        it "view more link doesn't present when all books are shown" do
          expect(page).not_to have_link(t('books.partials.view_more.button_view_more'))
        end
      end
    end

    describe "books length more then #{Pagy::DEFAULT[:items]}" do
      let(:books_count) { 15 }

      before do
        books_count.times { create(:book) }
        visit books_path
      end

      context "when books length more then #{Pagy::DEFAULT[:items]}" do
        it 'view more link already on page' do
          expect(page).to have_link(t('books.partials.view_more.button_view_more'))
        end
      end

      context "when books length more then #{Pagy::DEFAULT[:items]} with click" do
        it 'view more link already on page' do
          expect(page).to have_link(t('books.partials.view_more.button_view_more'))
          find_link(t('books.partials.view_more.button_view_more')).click
          expect(page).not_to have_link(t('books.partials.view_more.button_view_more'))
        end
      end
    end
  end

  describe 'when user want open book page' do
    describe 'page has link for this functionality' do
      let(:book1) { create(:book) }
      let(:book_page_path) { "/books/#{book1.id}" }

      before do
        book1
        visit books_path
      end

      it 'page has link for book_page' do
        expect(page).to have_link(:href => book_page_path)
      end

      context 'when user click on link' do
        it 'render book_page' do
          find_link(:href => book_page_path).click
          expect(page).to have_current_path(book_page_path, ignore_query: true)
        end
      end
    end
  end
end
