# frozen_string_literal: true

RSpec.describe Delivery, type: :model do
  describe 'Associations' do
    it { is_expected.to have_many(:orders) }
  end

  describe 'Table columns' do
    it { is_expected.to have_db_column(:name).of_type(:string).with_options(null: false) }
    it { is_expected.to have_db_column(:price).of_type(:float).with_options(null: false) }
    it { is_expected.to have_db_column(:from_date).of_type(:integer).with_options(null: false) }
    it { is_expected.to have_db_column(:to_date).of_type(:integer).with_options(null: false) }
  end
end
