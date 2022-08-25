# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Author, type: :model do
  describe 'Validates' do
    context 'when validate pass' do
      it 'is valid with valid attributes' do
        expect(build(:author)).to be_valid
      end
    end

    context 'when validate not pass' do
      let(:empty_value) { nil }

      it 'is not valid without a name' do
        expect(build(:author)).not_to allow_value(empty_value).for(:name)
      end
    end
  end

  describe 'Associations' do
    it { is_expected.to have_many(:books) }
  end
end
