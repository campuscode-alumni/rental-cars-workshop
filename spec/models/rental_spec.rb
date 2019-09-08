require 'rails_helper'

RSpec.describe Rental, type: :model do
  describe '#customer_cannot_rental_twice' do
    context 'personal customer' do
      it 'should rent once' do
        subsidiary = build(:subsidiary)
        user = build(:user, subsidiary: subsidiary)
        car = build(:car, subsidiary: user.subsidiary)
        customer = build(:personal_customer)
        create(:rental, car: car, user: user, customer: customer,
                        finished_at: Time.zone.today)
        rental = build(:rental, car: car, user: user, customer: customer)

        expect(rental).to be_valid
      end

      it 'should not rent twice' do
        subsidiary = build(:subsidiary)
        user = build(:user, subsidiary: subsidiary)
        car = build(:car, subsidiary: user.subsidiary)
        customer = build(:personal_customer)
        create(:rental, car: car, user: user, customer: customer,
                        finished_at: nil)
        rental = build(:rental, car: car, user: user, customer: customer)

        expect(rental).not_to be_valid
      end
    end

    context 'company customer' do
      it 'should rent twice' do
        subsidiary = build(:subsidiary)
        user = build(:user, subsidiary: subsidiary)
        car = build(:car, subsidiary: user.subsidiary)
        customer = build(:company_customer)
        create(:rental, car: car, user: user, customer: customer,
                        finished_at: nil)
        rental = build(:rental, car: car, user: user, customer: customer)

        expect(rental).to be_valid
      end
    end
  end
end
