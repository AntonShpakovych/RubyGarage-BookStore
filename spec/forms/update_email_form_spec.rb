# frozen_string_literal: true

RSpec.describe UpdateEmailForm, type: :model do
  let!(:current_user) { create(:user) }

  before { create_form.save }

  context 'when user want update email' do
    let(:expected_result_for_update_email) { params_for_email[:email] }
    let(:create_form) { described_class.new(current_user, params_for_email) }

    context 'when new email valid' do
      let(:params_for_email) { { email: 'new@gmail.com' } }

      let(:result_for_update_email) { create_form.email }

      it 'update user email' do
        expect(result_for_update_email).to eq(expected_result_for_update_email)
      end
    end

    context 'when new email invalid' do
      let(:params_for_email) { { email: '!@#!--new@gmail.com' } }

      let(:result_for_update_email) { current_user.email }

      it 'not update user email' do
        expect(current_user.email).not_to eq(expected_result_for_update_email)
      end
    end
  end
end
