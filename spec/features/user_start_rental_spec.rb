require 'rails_helper'

feature 'User start rental' do
  scenario 'successfully' do
    subsidiary = create(:subsidiary)
    user = create(:user, subsidiary: subsidiary)
    manufacture = create(:manufacture)
    car_model = create(:car_model, manufacture: manufacture)
    car = create(:car, car_model: car_model, subsidiary: user.subsidiary)
    customer = create(:personal_customer)
    rental = create(:scheduled_rental, car: car, customer: customer)

    login_as user
    visit root_path
    within('div#scheduled-rentals') do
      click_on "#{rental.id} - #{car.license_plate}"
    end
    click_on 'Confirmar Retirada'

    rental.reload
    expect(current_path).to eq rental_path(rental.id)
    expect(rental.active?).to be true
    expect(page).to have_content('Em andamento')
    expect(page).to have_link('Confirmar Devolução')
  end
end
