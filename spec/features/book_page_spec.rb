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

  describe 'Review' do
    let(:result) { page }
    let(:book) { create(:book) }
    let!(:user) { create(:user) }

    context 'when user want see all reviews from choosed book' do
      context 'when book not have reviews' do
        before { visit book_path(book.id) }

        let(:expected_text_count) do
          t('books.partials.reviews.count_reviews_title', count_reviews: book.reviews.approved.count)
        end

        it 'show count reviews' do
          expect(result).to have_text(expected_text_count)
        end
      end

      context 'when book have reviews' do
        let(:review) { create(:review, book_id: book.id, user_id: user.id) }

        let(:expected_text_count) do
          t('books.partials.reviews.count_reviews_title', count_reviews: book.reviews.approved.count)
        end

        let(:expected_title) { review.title }

        before do
          review.approved!
          visit book_path(book.id)
        end

        it 'show count all reviews from choosed book' do
          expect(result).to have_text(expected_text_count)
        end

        it 'show title review' do
          expect(result).to have_text(expected_title)
        end
      end
    end

    context 'when user want write new review' do
      context 'when user is sign_in' do
        let(:expected_text_new_review) { t('books.partials.write_review.write_a_review_title') }
        let(:submit_button) { t('books.partials.write_review.review_post') }

        before do
          visit new_user_session_path
          fill_in t('devise.placeholder.email'), with: user.email
          fill_in t('devise.placeholder.password'), with: user.password
          click_button t('devise.default.log_in')

          visit book_path(book.id)
        end

        it 'show form for new review' do
          expect(result).to have_text(expected_text_new_review)
        end

        context 'when user create valid review' do
          let(:expect_notice) { t('books.partials.write_review.good_create') }
          let(:expect_status) { 'unprocessed' }

          before do
            within('#new_review') do
              fill_in t('books.partials.write_review.review_form_title'), with: attributes_for(:review)[:title]
              fill_in t('books.partials.write_review.review_form_review'), with: attributes_for(:review)[:text]
              find('input#review_rating', visible: false).set(ReviewForm::MIN_RATING)
              click_button(submit_button)
            end
          end

          it 'show messsage u create new review' do
            expect(result).to have_text(expect_notice)
          end

          it 'also create review with status unprocessed' do
            expect(Review.last.status).to eq(expect_status)
          end
        end

        context 'when user create invalid review' do
          let(:expected_alert) { 'Rating must be greater than or equal to 1' }

          before do
            within('#new_review') do
              fill_in t('books.partials.write_review.review_form_title'), with: attributes_for(:review)[:title]
              fill_in t('books.partials.write_review.review_form_review'), with: attributes_for(:review)[:text]
              click_button(submit_button)
            end
          end

          it 'show message with errors' do
            expect(page).to have_text(expected_alert)
          end
        end
      end

      context 'when user is guest' do
        before { visit book_path(book.id) }

        let(:expect_message_need_sign_in) { t('books.show.message_review_for_not_authorized') }

        it 'show text u need to be sign_in' do
          expect(result).to have_text(expect_message_need_sign_in)
        end
      end
    end
  end

  describe 'Photo' do
    let!(:book) { create(:book) }
    let(:result_for_main_image) do
      page.find('img', class: 'img-responsive')['src']
    end
    let(:result_for_images) do
      page.all('img', class: 'catelog-book_image_show').map do |image|
        image['src']
      end
    end
    let(:expected_result_main_image) do
      /#{book.main_image}/
    end
    let(:expect_result_images) do
      book.images
    end

    before { visit book_path(book.id) }

    it 'user can see main_image choosed book' do
      expect(result_for_main_image).to match(expected_result_main_image)
    end

    it 'user can see other images choosed book' do
      result_for_images.each_with_index do |result_image, index|
        expect(result_image).to match(/#{expect_result_images[index]}/)
      end
    end
  end
end
