require 'rails_helper'

describe RentalDateQuery do
  describe '#first' do
    it 'should order by most rental' do
      subsidiary = create(:subsidiary)
      one_rental = create(:car, subsidiary: subsidiary)
      create(:rental, car: one_rental, start_at: Time.zone.today)
      other_subsidiary = create(:subsidiary)
      two_rental = create(:car, subsidiary: other_subsidiary)
      create_list(:rental, 2, car: two_rental, start_at: Time.zone.today)

      result = RentalDateQuery.new(1.day.ago..2.days.from_now).rentals_by_subsidiary

      expect(result[subsidiary.id]).to eq 1
      expect(result[other_subsidiary.id]).to eq 2
    end
  end
end
