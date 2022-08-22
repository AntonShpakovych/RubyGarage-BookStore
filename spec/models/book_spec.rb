# frozen_string_literal: true

RSpec.describe Book, type: :model do
  describe 'Validates' do
    context 'when validate pass' do
      it 'is valid with valid attributes' do
        expect(build(:book)).to be_valid
      end
    end

    context 'when validate not pass' do
      let(:empty_value) { nil }

      it 'is not valid without a name' do
        expect(build(:book, name: empty_value)).not_to be_valid
      end

      it 'is not valid without a description' do
        expect(build(:book, description: empty_value)).not_to be_valid
      end

      it 'is not valid without a quantity' do
        expect(build(:book, quantity: empty_value)).not_to be_valid
      end

      it 'is not valid without a width' do
        expect(build(:book, width: empty_value)).not_to be_valid
      end

      it 'is not valid without a height' do
        expect(build(:book, height: empty_value)).not_to be_valid
      end

      it 'is not valid without a length' do
        expect(build(:book, length: empty_value)).not_to be_valid
      end

      it 'is not valid without a year_of_publication' do
        expect(build(:book, year_of_publication: empty_value)).not_to be_valid
      end

      it 'is not valid without a materials' do
        expect(build(:book, materials: empty_value)).not_to be_valid
      end
    end
  end

  describe 'Associations' do
    it { is_expected.to belong_to(:category) }
  end
end
