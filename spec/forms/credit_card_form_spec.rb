# frozen_string_literal: true

RSpec.describe CreditCardForm, type: :model do
  let!(:order) { create(:order) }
  let(:params) do
    { name: credit_card.name, number: credit_card.number, date: credit_card.date, cvv: credit_card.cvv,
      order_id: order.id }
  end
  let(:credit_card_class) { CreditCard.find_or_initialize_by(order_id: order.id) }
  let(:credit_form) { described_class.new(credit_card, params) }
  let(:result) { order.credit_card }

  before { credit_form.save }

  context 'when valid' do
    let!(:credit_card) { create(:credit_card) }
    let(:expected_result) { credit_card }

    it 'create credit_card to order' do
      expect(result).to eq(expected_result)
    end
  end

  context 'when invalid' do
    context 'when invalid name' do
      let(:invalid_name) { '1!somename' }
      let(:credit_card) { create(:credit_card, name: invalid_name) }
      let(:result_name) { credit_form.errors[:name] }

      it 'not create credit_card for order' do
        expect(result).to be_nil
      end

      it 'also have errors for name' do
        expect(result_name).to be_present
      end
    end

    context 'when invalid number' do
      let(:invalid_number) { '1111' }
      let(:credit_card) { create(:credit_card, number: invalid_number) }
      let(:result_number) { credit_form.errors[:number] }

      it 'not create credit_card for order' do
        expect(result).to be_nil
      end

      it 'also have errors for number' do
        expect(result_number).to be_present
      end
    end

    context 'when invalid cvv' do
      let(:invalid_cvv) { '1' }
      let(:credit_card) { create(:credit_card, cvv: invalid_cvv) }
      let(:result_cvv) { credit_form.errors[:cvv] }

      it 'not create credit_card for order' do
        expect(result).to be_nil
      end

      it 'also have errors for cvv' do
        expect(result_cvv).to be_present
      end
    end

    context 'when invalid date' do
      let(:invalid_date) { '1112' }
      let(:credit_card) { create(:credit_card, date: invalid_date) }
      let(:result_date) { credit_form.errors[:date] }

      it 'not create credit_card for order' do
        expect(result).to be_nil
      end

      it 'also have errors for date' do
        expect(result_date).to be_present
      end
    end
  end
end
