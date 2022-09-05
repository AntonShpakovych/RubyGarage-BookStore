# frozen_string_literal: true

RSpec.describe BookDecorator do
  let(:author1) { create(:author) }
  let(:author2) { create(:author) }
  let(:decorator) { described_class.new(create(:book, authors: [author1, author2])) }

  describe '#all_authors' do
    let(:result) { decorator.all_authors }
    let(:expected_result) { "#{author1.name}, #{author2.name}" }

    it 'return all authors book' do
      expect(result).to eq(expected_result)
    end
  end

  describe '#short_description' do
    let(:result) { decorator.short_description.length }
    let(:expected_result) { described_class::SHORT_DESCRIPTION_LENGTH }

    it 'give truncated description to 250 characters' do
      expect(result).to eq(expected_result)
    end
  end

  describe '#dimensions' do
    let(:result) { decorator.dimensions }
    let(:expected_result) do
      t('books.show.dimensions', height: decorator.height, width: decorator.width, length: decorator.length)
    end

    it 'give message with format H: x W: x D:' do
      expect(result).to eq(expected_result)
    end
  end
end
