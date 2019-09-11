require 'rails_helper'

describe CarReturner do
  describe '#call' do
    it 'should return true if car returned' do
      car = create(:car, car_km: '100')
      customer = create(:personal_customer, email: 'lucas@gmail.com')
      rental = create(:rental, car: car, customer: customer)

      mailer = double('Mailer')
      allow(RentalMailer).to receive(:send_return_receipt).and_return(mailer)
      allow(mailer).to receive(:deliver_now)

      result = described_class.new(rental, 200).call

      expect(result).to be true
      expect(RentalMailer).to have_received(:send_return_receipt).with(rental.id)
    end

    it 'should not return car if not valid' do
      car = create(:car, car_km: 100)
      customer = create(:personal_customer, email: 'lucas@gmail.com')
      rental = create(:rental, car: car, customer: customer)
      allow(RentalMailer).to receive(:send_return_receipt)

      result = described_class.new(rental, 50).call

      expect(result).to be false
      expect(RentalMailer).not_to have_received(:send_return_receipt).with(rental.id)
    end
  end
end
