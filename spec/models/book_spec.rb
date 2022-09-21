# frozen_string_literal: true

RSpec.describe Book, type: :model do
  describe 'Table columns' do
    it { is_expected.to have_db_column(:name).of_type(:string) }
    it { is_expected.to have_db_column(:price).of_type(:decimal) }
    it { is_expected.to have_db_column(:width).of_type(:decimal) }
    it { is_expected.to have_db_column(:height).of_type(:decimal) }
    it { is_expected.to have_db_column(:length).of_type(:decimal) }
    it { is_expected.to have_db_column(:description).of_type(:text) }
    it { is_expected.to have_db_column(:quantity).of_type(:integer) }
    it { is_expected.to have_db_column(:year_of_publication).of_type(:integer) }
    it { is_expected.to have_db_column(:materials).of_type(:string) }
    it { is_expected.to have_db_column(:category_id).of_type(:integer) }
  end

  describe 'Validates' do
    context 'when validate not pass' do
      let(:empty_value) { nil }
      let(:book) { build(:book) }

      described_class.column_names do |colum_name|
        it "is not valid without a #{colum_name}" do
          expect(book).not_to allow_value(empty_value).for(colum_name)
        end
      end
    end
  end

  describe 'Associations' do
    it { is_expected.to belong_to(:category) }
  end
end
