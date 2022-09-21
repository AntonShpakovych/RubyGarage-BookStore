# frozen_string_literal: true

RSpec.describe BookQuery do
  describe '#call' do
    context 'when user not chosee category and filter' do
      let(:count_book) { 2 }
      let(:params) { {} }

      let(:result) { described_class.new(params).call.length }
      let(:expected_result) { count_book }

      before do
        create_list(:book, count_book)
      end

      it 'give all books we have' do
        expect(result).to eq(expected_result)
      end
    end

    context 'when user choose category but not choose filter' do
      let!(:first_category) { create(:category) }
      let!(:second_category) { create(:category) }

      let(:book_good) { create(:book, category: first_category) }
      let(:book_bad) { create(:book, category: second_category) }

      let(:params) { { category_id: first_category } }

      let(:result) { described_class.new(params).call.pluck(:category_id) }
      let(:expected_result_not_include) { :second_category }
      let(:expected_result_include) { :first_category }

      it 'give books, only with choosed category' do
        expect(result).not_to include(expected_result_not_include)
        expect(result).not_to include(expected_result_include)
      end
    end

    context 'when user choose filter but not choose category' do
      let(:filter) { BookQuery::DEFAULT_FILTER_KEY }

      let!(:book_desc) { create(:book, name: 'B') }
      let!(:book_asc) { create(:book, name: 'A') }

      let(:params) { { filter: filter } }

      let(:result1) { described_class.new(params).call.first.name }
      let(:result2) { described_class.new(params).call.second.name }

      let(:expected_result1) { book_asc.name }
      let(:expected_result2) { book_desc.name }

      it 'filter books by name' do
        expect(result1).to eq(expected_result1)
        expect(result2).to eq(expected_result2)
      end
    end

    context 'when user choose filter and category' do
      let(:filter) { BookQuery::DEFAULT_FILTER_KEY }
      let(:params) { { category_id: category_good.id, filter: filter } }

      let(:book_good_count) { 2 }
      let(:book_bad_count) { 3 }

      let!(:category_good) { create(:category) }
      let!(:category_bad) { create(:category) }

      let(:result_category) { described_class.new(params).call.length }
      let(:result_filter) { described_class.new(params).call.pluck(:name) }

      let(:expected_result_filter) { Book.where(category_id: category_good.id).order('name ASC').pluck(:name) }
      let(:expected_result_category) { Book.where(category_id: category_good.id).length }

      before do
        create_list(:book, book_good_count, { category: category_good })
        create_list(:book, book_bad_count, { category: category_bad })
      end

      it 'give books only with choosed category also filter books by filter' do
        expect(result_category).to eq(expected_result_category)
        expect(result_category).to eq(book_good_count)
        expect(result_filter).to eq(expected_result_filter)
      end
    end
  end
end
