require 'rails_helper'

describe RentalDecorator do
  describe '#started_at' do

    it 'should return --- for scheduled rentals' do
      car = create(:car)
      customer = create(:personal_customer)
      rental = create(:scheduled_rental, car: car, customer: customer)

      result = rental.decorate.started_at

      expect(result).to eq '---'
    end

    it 'should return started_at for active rentals' do
      car = create(:car)
      customer = create(:personal_customer)
      rental = create(:rental, car: car, customer: customer,
                     status: :active, started_at: '2019-01-01')

      result = rental.decorate.started_at

      expect(result).to eq DateTime.parse('2019-01-01')
    end

  end
end
