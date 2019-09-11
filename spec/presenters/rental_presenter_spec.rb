require 'rails_helper'

describe RentalPresenter do
  include Rails.application.routes.url_helpers
  describe '#status' do

    it 'should render a green badge for scheduled' do
      car = create(:car)
      customer = create(:personal_customer)
      rental = create(:scheduled_rental, car: car, customer: customer)

      result = RentalPresenter.new(rental).status

      expect(result).to match /span/
      expect(result).to match /badge-success/
      expect(result).to match /Agendada/
    end
  end

  describe '#withdraw_link' do
    it 'should render a link for scheduled' do
      car = create(:car)
      customer = create(:personal_customer)
      rental = create(:scheduled_rental, car: car, customer: customer)

      result = RentalPresenter.new(rental).withdraw_link

      expect(result).to match /a/
      expect(result).to include withdraw_rental_path(rental.id)
    end

    it 'should not render a link for active' do
      car = create(:car)
      customer = create(:personal_customer)
      rental = create(:rental, car: car, customer: customer,
                     status: :active)

      result = RentalPresenter.new(rental).withdraw_link

      expect(result).to eq ""
    end


  end
end
