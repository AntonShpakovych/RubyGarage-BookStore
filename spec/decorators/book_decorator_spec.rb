# frozen_string_literal: true

RSpec.describe BookDecorator do
  let(:author1) { create(:author) }
  let(:author2) { create(:author) }
  let(:book) { create(:book, authors: [author1, author2]) }
  let(:decorator_book) { book.decorate }

  describe '#all_authors' do
    let(:result) { decorator_book.all_authors }
    let(:expected_result) { "#{author1.name}, #{author2.name}" }

    let(:result_for_test_expected_result) { "#{author1.name}, #{author2.name}" }
    let(:expected_result_for_test_expected_result) { book.authors.pluck(:name).join(', ') }

    it 'return all authors book' do
      expect(result).to eq(expected_result)
      expect(result_for_test_expected_result).to eq(expected_result_for_test_expected_result)
    end
  end

  describe '#short_description' do
    let(:allowable_length) { described_class::SHORT_DESCRIPTION_LENGTH }

    context 'when description length more then allowable' do
      let(:result) { decorator_book.short_description.length }
      let(:expected_result) { allowable_length }

      let(:original_description_length) { decorator_book.description.length }

      it 'give truncated description to 250 characters' do
        expect(result).to eq(expected_result)
        expect(original_description_length).to be > allowable_length
      end
    end

    context 'when description length less then allowable' do
      let(:description_less_then_allowable) { 'Description less then allowable' }

      let(:result) { decorator_book.short_description.length }
      let(:expected_result) { decorator_book.description.length }

      let(:original_description_length) { decorator_book.description.length }

      before do
        decorator_book.description = description_less_then_allowable
      end

      it 'not truncated' do
        expect(result).to eq(expected_result)
        expect(original_description_length).to be < allowable_length
      end
    end
  end

  describe '#dimensions' do
    let(:result) { decorator_book.dimensions }
    let(:expected_result) do
      t('books.show.dimensions', height: book.height, width: book.width, length: book.length)
    end

    it 'give message with format H: x W: x D:' do
      expect(result).to eq(expected_result)
    end
  end
end
