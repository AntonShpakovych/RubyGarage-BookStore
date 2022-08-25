# frozen_string_literal: true

RSpec.describe Category, type: :model do
  describe 'Validates' do
    context 'when validate pass' do
      it 'is valid with valid attributes' do
        expect(build(:category)).to be_valid
      end
    end

    context 'when validate not pass' do
      let(:empty_value) { nil }

      it 'is not valid without a name' do
        expect(build(:category)).not_to allow_value(empty_value).for(:name)
      end
    end
  end

  describe 'Associations' do
    it { is_expected.to have_many(:books) }

    it 'give number of books in this category' do
      expect(build(:category_with_books).books.length).to be_a(Integer)
    end
  end
end
