require 'rails_helper'

RSpec.describe Rental, type: :model do
  context 'create' do
    describe '#customer_cannot_rental_twice' do
      it 'Should create successfully' do
        subsidiary = build(:subsidiary)
        user = build(:user, subsidiary: subsidiary)
        car = build(:car, subsidiary: user.subsidiary)
        customer = build(:customer, cpf: '123456789')
        create(:rental, car: car, user: user, customer: customer,
                        finished_at: Time.zone.today)
        rental = build(:rental, car: car, user: user, customer: customer)

        expect(rental).to be_valid
      end

      it 'Should not create' do
        subsidiary = build(:subsidiary)
        user = build(:user, subsidiary: subsidiary)
        car = build(:car, subsidiary: user.subsidiary)
        customer = build(:customer, cpf: '123456789')
        create(:rental, car: car, user: user, customer: customer,
                        finished_at: nil)
        rental = build(:rental, car: car, user: user, customer: customer)

        expect(rental).to be_invalid
      end
    end
  end
end
