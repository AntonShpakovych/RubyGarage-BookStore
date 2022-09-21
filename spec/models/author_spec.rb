# frozen_string_literal: true

RSpec.describe Author, type: :model do
  describe 'Validates' do
    context 'when validate not pass' do
      let(:empty_value) { nil }

      it 'is not valid without a name' do
        expect(build(:author)).not_to allow_value(empty_value).for(:name)
      end
    end
  end

  describe 'Table columns' do
    it { is_expected.to have_db_column(:name).of_type(:string) }
  end

  describe 'Associations' do
    it { is_expected.to have_many(:books).through(:author_books) }
    it { is_expected.to have_many(:author_books).dependent(:destroy) }
  end
end
