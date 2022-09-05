# frozen_string_literal: true

RSpec.describe User, type: :model do
  let(:user_build) { build(:user) }

  describe 'Validations' do
    context 'when validate pass' do
      it 'is valid with valid attributes' do
        expect(user_build).to be_valid
      end
    end

    context 'when validate not pass' do
      let(:empty_value) { nil }

      it 'is not valid without an email' do
        expect(user_build).not_to allow_value(empty_value).for(:email)
      end

      it 'is not valid without a password' do
        expect(user_build).not_to allow_value(empty_value).for(:password)
      end
    end
  end

  describe '.from_omniauth' do
    let(:auth) { OmniAuth::AuthHash.new(Faker::Omniauth.google) }
    let(:user) { described_class.from_omniauth(auth) }

    let(:result) { user.uid }
    let(:expected_result) { auth.uid }

    it 'returns user from facebook' do
      expect(result).to eq expected_result
    end
  end
end
