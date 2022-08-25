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
        expect(build(:book)).not_to allow_value(empty_value).for(:name)
      end

      it 'is not valid without a description' do
        expect(build(:book)).not_to allow_value(empty_value).for(:description)
      end

      it 'is not valid without a quantity' do
        expect(build(:book)).not_to allow_value(empty_value).for(:quantity)
      end

      it 'is not valid without a width' do
        expect(build(:book)).not_to allow_value(empty_value).for(:width)
      end

      it 'is not valid without a height' do
        expect(build(:book)).not_to allow_value(empty_value).for(:height)
      end

      it 'is not valid without a length' do
        expect(build(:book)).not_to allow_value(empty_value).for(:length)
      end

      it 'is not valid without a year_of_publication' do
        expect(build(:book)).not_to allow_value(empty_value).for(:year_of_publication)
      end

      it 'is not valid without a materials' do
        expect(build(:book)).not_to allow_value(empty_value).for(:materials)
      end
    end
  end

  describe 'Associations' do
    it { is_expected.to belong_to(:category) }
  end
end
