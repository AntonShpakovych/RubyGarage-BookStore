# frozen_string_literal: true

RSpec.describe Category, type: :model do
  describe 'Validates' do
    context 'when validate not pass' do
      let(:empty_value) { nil }
      let(:category) { build(:category) }

      it 'is not valid without a name' do
        expect(category).not_to allow_value(empty_value).for(:name)
      end
    end
  end

  describe 'Table column' do
    it { is_expected.to have_db_column(:name).of_type(:string) }
  end

  describe 'Associations' do
    it { is_expected.to have_many(:books) }
  end
end
