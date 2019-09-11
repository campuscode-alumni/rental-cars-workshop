require 'rails_helper'

describe FeaturedCarsQuery do
  describe '#first' do
    it 'should order by most rental' do
      one_rental = create(:car)
      create(:rental, car: one_rental)
      two_rental = create(:car)
      create_list(:rental, 2, car: two_rental)
      no_rental = create(:car)

      RentalDateQuery.new(1.day.ago..2.days.from_now).rentals_by_subsidiary
      result = FeaturedCarsQuery.new.first(5)

      expect(result.first).to eq two_rental
      expect(result.last).to eq no_rental
    end
  end
end
