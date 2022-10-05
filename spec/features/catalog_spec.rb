# frozen_string_literal: true

RSpec.describe 'Catalog page', type: :feature do
  describe 'Filtering and sorting' do
    context 'when user choose category' do
      let!(:category1) { create(:category) }
      let!(:category2) { create(:category) }
      let!(:book1) { create(:book, category: category1) }
      let!(:book2) { create(:book, category: category2) }

      let(:result) { page }
      let(:expected_result1) { book1.name }
      let(:expected_result2) { book2.name }

      before do
        visit books_path
        find('.filter-link', text: book1.category.name, match: :first).click
      end

      it 'shows books only from choosen category' do
        expect(result).to have_content(expected_result1)
        expect(result).not_to have_content(expected_result2)
      end
    end

    context 'when user choose filter' do
      let(:name_first) { 'AAAA' }
      let(:name_last) { 'BBBB' }
      let!(:book1) { create(:book, name: name_first) }

      let(:result) { page.find('.col-xs-6.col-sm-3', match: :first).text }
      let(:expected_result) { /#{book1.name}/ }

      before do
        visit books_path
        find('.dropdown-toggle.lead.small', text: t('books.partials.desktop.filter.name_asc'), match: :first).click
      end

      it "sorting books by #{BookQuery::ORDERS_TYPE.keys.first}" do
        expect(result).to match(expected_result)
      end
    end
  end

  describe 'Pagination' do
    describe "books length less #{Pagy::DEFAULT[:items]}" do
      let(:books_count) { 5 }

      let(:result) { page }
      let(:expected_result) { t('books.partials.view_more.button_view_more') }

      before do
        create_list(:book, books_count)
        visit books_path
      end

      it "view more link doesn't present when all books are shown" do
        expect(result).not_to have_link(expected_result)
      end
    end

    describe "books length more then #{Pagy::DEFAULT[:items]}" do
      let(:books_count) { 15 }
      let(:result) { page }
      let(:expected_result) { t('books.partials.view_more.button_view_more') }

      before do
        create_list(:book, books_count)
        visit books_path
      end

      it 'view more link already on page' do
        expect(result).to have_link(expected_result)
      end
    end
  end

  describe 'when user want open book page' do
    let!(:book1) { create(:book) }
    let(:book_page_path) { "/books/#{book1.id}" }
    let(:result) { page }
    let(:expected_result) { { :href => book_page_path } }

    before do
      visit books_path
    end

    it 'page has link for book_page' do
      expect(result).to have_link(expected_result)
    end

    context 'when user click on link' do
      let(:expected_result) { book_page_path }

      before { find_link(:href => book_page_path).click }

      it 'render book_page' do
        expect(result).to have_current_path(expected_result, ignore_query: true)
      end
    end
  end

  describe 'main_image' do
    let(:result) do
      within('.general-thumb-wrap') do
        page.find('img', class: 'img-shadow general-thumbnail-img book-logo_img')['src']
      end
    end

    context 'when book has main_image' do
      let!(:book) { create(:book) }
      let(:expected_result) { /#{book.main_image}/ }

      before { visit books_path }

      it 'user can see main_image on page' do
        expect(result).to match(expected_result)
      end
    end

    context 'when book without main_image' do
      let(:expected_result) { /#{book_image_default}/ }

      before do
        create(:book, main_image: nil)
        visit books_path
      end

      it 'user can see default image on page' do
        expect(result).to match(expected_result)
      end
    end
  end

  describe 'Cart' do
    let(:result) { page }
    let!(:book) { create(:book) }
    let(:add_to_card_link) do
      within('.thumb-hover') do
        page.all('a', class: 'thumb-hover-link').last
      end
    end

    context 'when cart not have choosed book' do
      let(:expected_result_message) { t('carts.message.create_good') }

      before do
        visit books_path
        add_to_card_link.click
      end

      it 'show notice with information create was all good' do
        expect(result).to have_text(expected_result_message)
      end
    end

    context 'when cart already have choosed book' do
      let(:current_order) { Order.find_by(status: :unprocessed) }
      let(:set_order_items_with_choosed_book) do
        create(:order_item, book: book, order: current_order)
      end
      let(:expected_result_message) { t('carts.message.create_bad') }

      before do
        visit books_path
        set_order_items_with_choosed_book
        add_to_card_link.click
      end

      it 'show alert with failure' do
        expect(result).to have_text(expected_result_message)
      end
    end
  end
end
