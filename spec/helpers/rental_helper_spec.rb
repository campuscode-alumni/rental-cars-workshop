require 'rails_helper'

RSpec.describe RentalHelper, type: :helper do
  context '#status' do
    it 'should render a green badge for scheduled' do
      car = create(:car)
      customer = create(:personal_customer)
      rental = create(:scheduled_rental, car: car, customer: customer)

      result = status(rental)

      expect(result).to match /span/
      expect(result).to match /badge-success/
      expect(result).to match /Agendada/
    end

    it 'should render a blue badge for active' do
      car = create(:car)
      customer = create(:personal_customer)
      rental = create(:rental, car: car, customer: customer, status: :active)

      result = status(rental)
      expect(result).to match /span/
      expect(result).to match /badge-primary/
      expect(result).to match /Em Andamento/
    end
  end
end
