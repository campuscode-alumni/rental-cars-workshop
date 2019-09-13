require 'rails_helper'

describe ReturnCarJob do
  describe '.auto_enqueue' do
    it 'should perform successfully' do
      car = create(:car, status: :rented)
      rental = create(:rental, car: car, started_at: Time.zone.now)

      described_class.auto_enqueue(rental.id)

      expect(Delayed::Worker.new.work_off).to eq [1, 0]
    end

    it 'should change rental to finalize' do
      car = create(:car, status: :rented)
      rental = create(:rental, car: car, started_at: Time.zone.now)
      mail = double('Mailer')
      mailer_spy = class_spy(RentalMailer)
      stub_const('RentalMailer', mailer_spy)
      allow(RentalMailer).to receive(:send_rental_receipt)
        .with(rental.id).and_return(mail)
      allow(mail).to receive(:deliver_now)

      described_class.auto_enqueue(rental.id)

      expect(Delayed::Worker.new.work_off).to eq [1, 0]
      expect(rental.reload).to be_finished
      expect(mailer_spy).to have_received(:send_rental_receipt).with(rental.id)
    end
  end
end