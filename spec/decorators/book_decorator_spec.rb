# frozen_string_literal: true

RSpec.describe BookDecorator do
  let(:author1) { create(:author) }
  let(:author2) { create(:author) }
  let(:decorator) { described_class.new(create(:book, authors: [author1, author2])) }

  describe '#all_authors' do
    let(:response_for_all_authors) { decorator.authors.map(&:name).join(',') }

    it 'return all authors book' do
      expect(decorator.all_authors).to eq(response_for_all_authors)
    end
  end

  describe '#short_description' do
    it 'give truncated description to 250 characters' do
      expect(decorator.short_description.length).to eq(described_class::SHORT_DESCRIPTION_LENGTH)
    end
  end

  describe '#dimensions' do
    let(:template) do
      t('books.show.dimensions', height: decorator.height, width: decorator.width, length: decorator.length)
    end

    it 'give message with format H: x W: x D:' do
      expect(decorator.dimensions).to eq(template)
    end
  end
end
