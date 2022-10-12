# frozen_string_literal: true

RSpec.describe ConfirmedOrderMailer, type: :mailer do
  describe '#confirm_order_email' do
    let(:mail) { described_class.confirm_order_email(email) }
    let(:email) { 'test@gmail.com' }
    let(:expected_result_from) { 'fast-temple-25283.herokuapp.com' }

    let(:reusult_to) { mail.to }
    let(:expected_result_to) { email }

    let(:result_from) { mail.from }
    let(:result_message) { mail.body.encoded }
    let(:expected_result_message) { t('checkouts.confrim_order_mailer.email') }

    it 'renders the headers' do
      expect(reusult_to).to eq([expected_result_to])
      expect(result_from).to eq([expected_result_from])
    end

    it 'renders the body' do
      expect(result_message).to match(expected_result_message)
    end
  end
end
