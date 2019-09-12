require 'rails_helper'

describe RentalByPeriodQuery do
  describe 'call' do
    it 'should count rentals by subsidiaries' do
      customer = create(:company_customer, email: 'bla@ble.com')
      user = create(:user, email: 'joao@email.com')
      start = 3.days.ago
      finish = 1.day.ago

      subsidiary = create(:subsidiary, name: 'Matriz')
      car = create(:car, subsidiary: subsidiary)
      create_list(:finished_rental, 5, car: car, customer: customer,
                  started_at: 2.days.ago, user: user)

      other_subsidiary = create(:subsidiary, name: 'Campus Code')
      other_car = create(:car, subsidiary: other_subsidiary)
      create_list(:finished_rental, 10, car: other_car, customer: customer,
                  started_at: 2.days.ago, user: user)

      result = described_class.new(start..finish).call

      expect(result[subsidiary.id]).to eq 5
      expect(result[other_subsidiary.id]).to eq 10

    end

    it 'should count subsidiaries with no rentals' do
      customer = create(:company_customer, email: 'bla@ble.com')
      user = create(:user, email: 'joao@email.com')
      start = 3.days.ago
      finish = 1.day.ago

      subsidiary = create(:subsidiary, name: 'Matriz')
      car = create(:car, subsidiary: subsidiary)
      create_list(:finished_rental, 5, car: car, customer: customer,
                  started_at: 2.days.ago, user: user)

      other_subsidiary = create(:subsidiary, name: 'Campus Code')

      result = described_class.new(start..finish).call

      expect(result[subsidiary.id]).to eq 5
      expect(result[other_subsidiary.id]).to eq nil

    end

  end
end
